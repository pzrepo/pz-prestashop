<?php
////////////// Settings //////////////
// split_member is "Y"	
$flight_mode = 'Y';
$delay_days = 2;
$Awaiting_Pzprestashop_payment = 208;
$Pzprestashop_Payment_Success = 209;
$Pzprestashop_Payment_Partial_Success = 210;
$Pzprestashop_Payment_Failed = 211;

$user_id = $orders['user_id']; // 1011
$trackingid = ($orders['pzprestashop_id'] == NULL) ? '' : $orders['pzprestashop_id'];
$id_order = $orders['id_order'];
$toid = $orders['merchant_id']; // 10688
$reference = $orders['reference'];
$secure_key = $orders['secure_key'];
$secret_key = $datavalue['secret_key'];
$connection_mode = $orders['connection_mode']; // off / on
$current_state = $orders['current_state'];
$date_add = $orders['date_add'];
$isProcessed = (int) 0;

// see 2
$order_details_reference = $ordersdetail['order_details_id']; // order_reference_0, _1, _2...
if ($flight_mode == "N") {
	$str = "$toid|$order_details_reference|$trackingid|$secret_key";
} else {
	$str = "$toid|$order_details_reference|$trackingid";
}
$generatedCheckSum = md5($str);

if (($current_state == $Awaiting_Pzprestashop_payment || $current_state == $Pzprestashop_Payment_Partial_Success || $current_state == $Pzprestashop_Payment_Success) &&
	($isProcessed == 0)) {

	$jsonRequest = '{"toId": ' . $toid . ',"checkSum": "' . $generatedCheckSum . '","description": "' . $order_details_reference . '","trackingId": ""}';
	$ch = curl_init();
	//$url = "#"; // here server url will come
	$ssl = _PS_BASE_URL_ . __PS_BASE_URI__ . "modules/pzprestashop/ssl.cer"; // maybe it is not needed. TBC
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_CAINFO, $ssl);
	curl_setopt($ch, CURLOPT_VERBOSE, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonRequest);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
		'Content-Type: application/json',
		'Accept: application/json'
	));
	$result = curl_exec($ch);
	$jsonResponse = json_decode($result, true);
	$transactionStatus = sanitizeTransactionStatus($jsonResponse['status']);
	$trackingId = $jsonResponse['trackingId'];
	$statusDescription = ($jsonResponse['statusDescription']) ? (string) $jsonResponse['statusDescription'] : '';

	if ($transactionStatus == 'failed') {
		if (($connection_mode == 'on' && $current_state == $Awaiting_Pzprestashop_payment) || 
			($connection_mode == 'off' && ($current_state == $Awaiting_Pzprestashop_payment || $current_state == $Pzprestashop_Payment_Success) && (strtotime($date_add) < strtotime('-' . $delay_days . ' days')))){
			updateTransaction($order_details_reference, $trackingId, 'failed', $statusDescription);
		} else{
			// keep 'pending'
		}
	} else {
		updateTransaction($order_details_reference, $trackingId, $transactionStatus, $statusDescription);
	}
}

function sanitizeTransactionStatus($transactionStatus)
{
	$validStatuses = array(
		'authsuccess',
		'capturesuccess',
		'settled',
		'markedforreversal',
		'reversed', 'chargeback',
		'authstarted',
		'proofrequired',
		'failed'
	);
	if (in_array($transactionStatus, $validStatuses)) {
		return $transactionStatus;
	} else {
		return 'failed';
	}
}

function updateTransaction($transactionId, $transactionTrackingId, $transactionStatus, $transactionStatusDescription)
{
	if (isset($transactionTrackingId)) {
		$updateSQL = "update " . _DB_PREFIX_ . "pzprestashop_orderdetails set status='$transactionStatus', tracking_id='$transactionTrackingId',  where order_details_id='$transactionId'";
	} else {
		$updateSQL = "update " . _DB_PREFIX_ . "pzprestashop_orderdetails set status='$transactionStatus' where order_details_id='$transactionId'";
	}
}
