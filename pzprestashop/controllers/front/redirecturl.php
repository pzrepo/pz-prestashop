<?php
class pzprestashopRedirecturlModuleFrontController extends ModuleFrontController
{
    public $ssl = true;
    public $display_column_left = false;


    public function initContent()
    {
        parent::initContent();
        $this->orderstbl = 'orders';

        $trackingid = Tools::getValue('trackingid');
		if($trackingid=="")
		{
			$trackingid="null";
		}
        $desc = Tools::getValue('desc');
		
        $key=Configuration::get('key');
        $id_order=Tools::getValue('orderid');
        $amount = Tools::getValue('amount');
		
        $status = Tools::getValue('status');
		if($status=="C")
		{
			$key="null";
		}
        $checksum = Tools::getValue('checksum');
        $descriptor = Tools::getValue('descriptor');

        $currency = new CurrencyCore($this->context->cart->id_currency);   // get currency iso code
        $cart_currency_iso = $currency->iso_code;
        
        $merchant_config = $this->getMerchantDetails($cart_currency_iso,$amount);        	


	
        	
        $str = "$trackingid|$desc|$amount|$status|$key";
        $generatedCheckSum = md5($str);
        if($generatedCheckSum == $checksum)
            $retval = "true" ;
        else
            $retval = "false" ;

		 //updating connection mode  and merchant id and tracking id(pzprestashop_id).
			$trackingid=$_REQUEST['trackingid'];
		if($retval == "false")
		{
			
			// checksum issue
            $objOrder = new Order($id_order);
            $history = new OrderHistory();
            $history->id_order = (int)$objOrder->id;
            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_SECURITY_ERROR'));
			$this->setTemplate('securityError.tpl');
			
		}
		else if($retval == "true" && $status == "Y")
        {
			$order_reff=$_REQUEST['desc'];

            $objOrder = new Order($id_order); //order with id=1
            $history = new OrderHistory();
            $history->id_order = (int)$objOrder->id;		
            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_SUCCESS'));			
            $showMyMagazinesLink = false;
			$id_products_unique = array();
			$order = new Order($id_order);
			$orderState = $order->getCurrentOrderState();
			if (
				$order->valid && $orderState->paid && 
				$order->flight == Configuration::get('M4X_FLIGHT') && 
				strtotime($order->invoice_date) > time() - Configuration::get('MAGAZINES_TIME_VALIDITY') * 60 *60
				)
			{
				$products = $order->getProducts();
				foreach($products as $product){
					$id_product = $product['product_id'];
					if (!in_array($id_product, $id_products_unique)){
						$id_products_unique[] = $id_product;
						$productCategories = Product::getProductCategories($id_product);
						if (in_array(Configuration::get('ID_CATEGORY_MAGAZINES'), $productCategories)){
							$showMyMagazinesLink = true;
						}
					}
				}
			}

            $this->context->smarty->assign(array(
                    'desc' => $desc,
                    'amount' => $amount,
					'trackingid'=>$trackingid,
                    'shop_name' => $shop_name,
					'showMyMagazinesLink' => $showMyMagazinesLink,
            ));
           
				
				$this->setTemplate('success.tpl');
                    

        }
        else if($retval == "true" && $status == "N")
        {
			
			
			$order_reff=$_REQUEST['desc'];	
			$terminal_counts=count($failedTerminals);
			$terminalIds="";
			for($l=0;$l<$terminal_counts;$l++)
			{
				$faileddataArray=$failedTerminals[$l];
				
				$TerminalWithAmount=explode("=",$faileddataArray);
				
				$terminalIds.=$TerminalWithAmount[0].",";
	
			}
            $objOrder = new Order($id_order); //order with id=1
            $history = new OrderHistory($id_order);
            $history->id_order = (int)$objOrder->id;
            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_FAILED'));    
            $this->context->smarty->assign(array(
                    'desc' => $desc,
                    'amount' => $amount,
					'trackingid'=>$trackingid,
                    'shop_name', $shop_name
            ));
            $this->setTemplate('transactionFailed.tpl');
        }
		else if($retval == "true" && $status == "P")
        {
           
		   //update status in pzprestashop_orderDetails table.
			
			$order_reff=$_REQUEST['desc'];
			$objOrder = new Order($id_order); //order with id=1
            $history = new OrderHistory();
            $history->id_order = (int)$objOrder->id;
            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_PARTIALLYSUCCESS'));			
            $this->context->smarty->assign(array(
                    'desc' => $desc,
                    'amount' => $amount,
					'trackingid'=>$trackingid,
                    'shop_name', $shop_name
            ));
           
				
				$this->setTemplate('partiallysuccess.tpl');
				
        }
        
	else if ($retval == "true" && $status == "C")
        {
			// cancelled by the user
            $objOrder = new Order($id_order); //order with id=1
            $history = new OrderHistory();
            $history->id_order = (int)$objOrder->id;
            //$history->changeIdOrderState(8, (int)($objOrder->id));
            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_CANCELLED')); 
            $this->context->smarty->assign(array(
                    'desc' => $desc,
                    'amount' => $amount,
					'shop_name', $shop_name
            ));
			
            $this->setTemplate('cancel.tpl');
        }
		else
			{
			$objOrder = new Order($id_order); 

            $history = new OrderHistory();

            $history->id_order = (int)$objOrder->id;

            $objOrder->setCurrentState(Configuration::get('PS_OS_PZPRESTASHOP_UNKNOWN_STATUS'));		

			$this->setTemplate('unkownStatus.tpl');

		}
       
    }

    /**
     *collect all merchant details
     *@author Dev-102
     *@param String $currency_iso Currency ISO Code
     *@return array $merchant_details Merchant Configuration details
     */

    public function getMerchantDetails($currency_iso,$total)
    {
        $merchant_details = array();
        $order_total = $total;

        $SQL = "SELECT * FROM "._DB_PREFIX_.$this->module->name." WHERE `currency` = '".$currency_iso."' AND `min_amount` <= ".$order_total." AND `max_amount` >= ".$order_total;
        $result = Db::getInstance()->executeS($SQL);
        foreach($result as $key=>$merchant)
        {
            $merchant_details['merchant_id'] = $merchant['merchant_id'];
            $merchant_details['secret_key'] = $merchant['secret_key'];
        }
        return $merchant_details;
    }
}