<?php

class pzprestashopValidationModuleFrontController extends ModuleFrontController
{
	/**
	 * @see FrontController::postProcess()
	 */
		public $ssl = true;
		public $display_column_left = false;
                
	public function postProcess()
	{
		$cart = $this->context->cart;
		if ($cart->id_customer == 0 || !$this->module->active)
			Tools::redirect('index.php?controller=order&step=1');		

                if (!Tools::getValue('ignoreAddress')){
			if ($cart->id_address_delivery == 0 || $cart->id_address_invoice == 0)
				Tools::redirect('index.php?controller=order&step=1');
		}		

		// Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
		$authorized = false;
		foreach (Module::getPaymentModules() as $module)
		{
			if ($module['name'] == 'pzprestashop')
			{
				$authorized = true;
				break;
			}
		}
		if (!$authorized)
			die($this->module->l('This payment method is not available.', 'validation'));

		$customer = new Customer($cart->id_customer);
 		if (!Validate::isLoadedObject($customer))
			Tools::redirect('index.php?controller=order&step=1');

		$currency = $this->context->currency;
		$total = (float)$cart->getOrderTotal(true, Cart::BOTH);
		$mailVars = array(
				'{toid}' => Configuration::get('toid'),
				'{totype}' => nl2br(Configuration::get('totype')),
				'{partenerid}' => nl2br(Configuration::get('partenerid')),
				'{processingurl}' => nl2br(Configuration::get('processingurl')),
				'{ipaddr}' => nl2br(Configuration::get('ipaddr')),
				'{key}' => nl2br(Configuration::get('key')),
		);


		$this->module->validateOrder($cart->id,Configuration::get('PS_OS_PZPRESTASHOP_AWAITING'), $total, $this->module->displayName, NULL, $mailVars, (int)$currency->id, false, $customer->secure_key);
		$cart = $this->context->cart;
		if (!$this->module->checkCurrency($cart))
			Tools::redirect('index.php?controller=order');

		$currency = new CurrencyCore($this->context->cookie->id_currency);
		$currency_iso_code = $currency->iso_code;
		$cart_products = $this->context->cart->getProducts();
		$array_container=array();
		foreach($cart_products as $cart_product){
			$id_supplier    = $cart_product['id_supplier'];
			if (array_key_exists($id_supplier, $array_container)) {
				$array_container[]=$id_supplier;	
			}else{
				$array_container[]=$id_supplier;
			}	
		}
		$currency = new CurrencyCore($cart->id_currency);   // get currency iso code
		$my_currency_iso_code = $currency->iso_code;
		$my_currency_rate = $currency->conversion_rate;
		$total = $cart->getOrderTotal(true, Cart::BOTH);					

		$order = new Order($this->module->currentOrder);
		$orderid = $order->getUniqReference();

		$redirecturl = $this->context->link->getModuleLink('pzprestashop', 'redirecturl', array("orderid"=>$this->module->currentOrder), true);

		$totype = Configuration::get('totype');
		//$partenerid = Configuration::get('partenerid');
		$toid =Configuration::get('toid'); // here change toid
		$keys=Configuration::get('key');
		$currency = new CurrencyCore($cart->id_currency);
                $currency_iso_code = $currency->iso_code;

		$array_container = array();
		$cart_products = $this->context->cart->getProducts();
		foreach($cart_products as $cart_product){
			$price          = $cart_product['total_wt'];
			$id_supplier    = $cart_product['id_supplier'];
			$quantity    = $cart_product['quantity'];
			$dprice=number_format($dprice,  2, '.', '')+(number_format($price,  2, '.', ''));
			$array_container[$id_supplier]=number_format($dprice,  2, '.', '');
			
		}
		
		foreach($array_container as $key => $value){
			$mykey[] = $key;
			$myvalue[] = $value;
		}

		$counts=count($mykey);
		for($j=0;$j<$counts;$j++){                        
                        $totalAmount=number_format($totalAmount, 2, '.', '')+number_format($myvalue[$j], 2, '.', '');
			$z++;
		}

		if($z>1)
		{
			$Amount=number_format($totalAmount, 2, '.', '');
		}
		else
		{
			$Amount=number_format($totalAmount, 2, '.', '');
		}

		$merchantid1=Configuration::get('merchantid1');
		//$partenerid=Configuration::get('partenerid');
		$string = "$merchantid1|$totype|$Amount|$orderid|$redirecturl|$keys";
		$checksum = md5($string);

		Tools::addCSS(_PS_BASE_URL_._MODULE_DIR_ . $this->module->name. '/views/css/pzprestashop.css');
                
                $url="";
                if(Configuration::get('test_mode') =="Y")
                { 
                  $url=Configuration::get("processingurl");
                  
                }
                else
                {
				   $url=Configuration::get("liveurl");
                  
                }    

				/**********************************************************************************************************/
				
				 $country_sql = 'SELECT * FROM '._DB_PREFIX_.'customer WHERE email ="'.$this->context->customer->email.'"';
                    if ($country_row = Db::getInstance()->getRow($country_sql))
                    $country_id_country = $country_row['id_customer'];
				
				
				 $address_sql = 'SELECT * FROM '._DB_PREFIX_.'address WHERE id_customer =' . $country_id_country;
                    if ($address_row = Db::getInstance()->getRow($address_sql))
                          $address_id_state = $address_row['id_state'];
                          $address_address1 = $address_row['address1'] . " " .$address_row['address2'];
                          $address_city = $address_row['city'];
                          $address_postcode = $address_row['postcode'];
                          $address_phone = $address_row['phone'];
                
				
				$sql = 'SELECT * FROM '._DB_PREFIX_.'state WHERE id_state =' .$address_id_state;
                    if ($row = Db::getInstance()->getRow($sql))
                        $row['iso_code'];
				/**********************************************************************************************************/
				
				
				
				/********************************************/
			
					$country_code = array(
					"AF"=>"093", 
					"AX"=>"358", 
					"AL"=>"355",
					"DZ"=>"231",
					"AS"=>"684",
					"AD"=>"376",
					"AO"=>"244",
					"AI"=>"001",
					"AQ"=>"000",
					"AG"=>"001",
					"AR"=>"054",
					"AM"=>"374",
					"AW"=>"297",
					"AU"=>"061",
					"AT"=>"043",
					"AZ"=>"994",
					"BS"=>"001",
					"BH"=>"973",
					"BD"=>"880",
					"BB"=>"001",
					"BY"=>"375",
					"BE"=>"032",
					"BZ"=>"501",
					"BJ"=>"229",
					"BM"=>"001",
					"BT"=>"975",
					"BO"=>"591",
					"BA"=>"387",
					"BW"=>"267",
					"BV"=>"000",
					"BR"=>"055",
					"IO"=>"246",
					"VG"=>"001",
					"BN"=>"673",
					"BG"=>"359",
					"BF"=>"226",
					"BI"=>"257",
					"KH"=>"855",
					"CM"=>"237",
					"CA"=>"001",
					"CV"=>"238",
					"KY"=>"001",
					"CF"=>"236",
					"TD"=>"235",
					"CL"=>"056",
					"CN"=>"086",
					"CX"=>"061",
					"CC"=>"061",
					"CC"=>"061",
					"CO"=>"057",
					"KM"=>"269",
					"CK"=>"682",
					"CR"=>"506",
					"CI"=>"225",
					"HR"=>"385",
					"CU"=>"053",
					"CY"=>"357",
					"CZ"=>"420",
					"CD"=>"243",
					"DK"=>"045",
					"DJ"=>"253",
					"DM"=>"001",
					"DO"=>"001",
					"EC"=>"593",
					"EG"=>"020",
					"SV"=>"503",
					"GQ"=>"240",
					"ER"=>"291",
					"EE"=>"372",
					"ET"=>"251",
					"FK"=>"500",
					"FO"=>"298",
					"FJ"=>"679",
					"FI"=>"358",
					"FR"=>"033",
					"GF"=>"594",
					"PF"=>"689",
					"TF"=>"000",
					"GA"=>"241",
					"GM"=>"220",
					"GE"=>"995",
					"DE"=>"049",
					"GH"=>"233",
					"GI"=>"350",
					"GR"=>"030",
					"GL"=>"299",
					"GD"=>"001",
					"GP"=>"590",
					"GU"=>"001",
					"GT"=>"502",
					"GG"=>"000",
					"GN"=>"224",
					"GW"=>"245",
					"GY"=>"592",
					"HT"=>"509",
					"HM"=>"672",
					"HN"=>"504",
					"HK"=>"852",
					"HU"=>"036",
					"IS"=>"354",
					"IN"=>"091",
					"ID"=>"062",
					"IR"=>"098",
					"IQ"=>"964",
					"IE"=>"353",
					"IL"=>"972",
					"IT"=>"039",
					"JM"=>"001",
					"JP"=>"081",
					"JE"=>"044",
					"JO"=>"962",
					"KZ"=>"007",
					"KE"=>"254",
					"KI"=>"686",
					"KW"=>"965",
					"KG"=>"996",
					"LA"=>"856",
					"LV"=>"371",
					"LB"=>"961",
					"LS"=>"266",
					"LR"=>"231",
					"LY"=>"218",
					"LI"=>"423",
					"LT"=>"370",
					"LU"=>"352",
					"MO"=>"853",
					"MK"=>"389",
					"MG"=>"261",
					"MW"=>"265",
					"MY"=>"060",
					"MV"=>"960",
					"ML"=>"223",
					"MT"=>"356",
					"MH"=>"692",
					"MQ"=>"596",
					"MR"=>"222",
					"MU"=>"230",
					"YT"=>"269",
					"MX"=>"052",
					"FM"=>"691",
					"MD"=>"373",
					"MC"=>"377",
					"MN"=>"976",
					"ME"=>"382",
					"MS"=>"001",
					"MA"=>"212",
					"MZ"=>"258",
					"MM"=>"095",
					"NA"=>"264",
					"NR"=>"674",
					"NP"=>"977",
					"AN"=>"599",
					"NL"=>"031",
					"NC"=>"687",
					"NZ"=>"064",
					"NI"=>"505",
					"NE"=>"227",
					"NG"=>"234",
					"NU"=>"683",
					"NF"=>"672",
					"KP"=>"850",
					"MP"=>"001",
					"NO"=>"047",
					"OM"=>"968",
					"PK"=>"092",
					"PW"=>"680",
					"PS"=>"970",
					"PA"=>"507",
					"PG"=>"675",
					"PY"=>"595",
					"PE"=>"051",
					"PH"=>"063",
					"PN"=>"064",
					"PL"=>"048",
					"PT"=>"351",
					"PR"=>"001",
					"QA"=>"974",
					"CG"=>"242",
					"RE"=>"262",
					"RO"=>"040",
					"RU"=>"007",
					"RW"=>"250",
					"BL"=>"590",
					"SH"=>"290",
					"KN"=>"001",
					"LC"=>"001",
					"MF"=>"590",
					"PM"=>"508",
					"VC"=>"001",
					"WS"=>"685",
					"SM"=>"378",
					"ST"=>"239",
					"SA"=>"966",
					"SN"=>"221",
					"RS"=>"381",
					"SC"=>"248",
					"SL"=>"232",
					"SG"=>"065",
					"SK"=>"421",
					"SI"=>"386",
					"SB"=>"677",
					"SO"=>"252",
					"ZA"=>"027",
					"GS"=>"000",
					"KR"=>"082",
					"ES"=>"034",
					"LK"=>"094",
					"SD"=>"249",
					"SR"=>"597",
					"SJ"=>"047",
					"SZ"=>"268",
					"SE"=>"046",
					"CH"=>"041",
					"SY"=>"963",
					"TW"=>"886",
					"TJ"=>"992",
					"TZ"=>"255",
					"TH"=>"066",
					"TL"=>"670",
					"TG"=>"228",
					"TK"=>"690",
					"TO"=>"676",
					"TT"=>"001",
					"TN"=>"216",
					"TR"=>"090",
					"TM"=>"993",
					"TC"=>"001",
					"TV"=>"688",
					"UG"=>"256",
					"UA"=>"380",
					"AE"=>"971",
					"GB"=>"044",
					"US"=>"001",
					"VI"=>"001",
					"UY"=>"598",
					"UZ"=>"998",
					"VU"=>"678",
					"VA"=>"379",
					"VE"=>"058",
					"VN"=>"084",
					"WF"=>"681",
					"EH"=>"212",
					"YE"=>"967",
					"ZM"=>"260",
					"ZW"=>"263",
					);
			$country_value = $country_code[$this->context->country->iso_code];
			/*******************************************/
				
				
		$this->context->smarty->assign($testarray= array(
				'content_only' => 1,
				"toid"=>$merchantid1,
				"totype"=>$totype,				
				"partenerid"=>Configuration::get('partenerid'),				
				//"partenerid"=>"1012",				
				"pctype"=>"1_1|1_2",				
				"paymenttype"=>"",				
				"cardtype"=>"",				
				"reservedField1"=>"",				
				"reservedField2"=>"",				
				"ipaddr"=>Configuration::get('ipaddr'),
				"amount"=>$Amount,
				"description"=>$orderid,
				"redirecturl"=>$redirecturl,
				"checksum"=>$checksum,
				"firstname"=>$this->context->customer->firstname,
				"lastname"=>$this->context->customer->lastname,
				"TMPL_street"=>$address_address1,
				"TMPL_city"=>$address_city,
				"TMPL_COUNTRY"=>$this->context->country->iso_code,
				"TMPL_state"=>$row['iso_code'],
				"TMPL_CURRENCY"=>$my_currency_iso_code,
				"TMPL_zip"=>$address_postcode,
				"TMPL_telno"=>$address_phone,
				"TMPL_telnocc"=>$country_value,
				"TMPL_emailaddr"=>$this->context->customer->email,
				"orderdescription"=>$orderid,
				"orderid"=>$orderid,
				"processingurl"=>$url,
		));
		//var_dump($testarray);
		$this->setTemplate('redirect.tpl');
	}
	
	

	/**
	 *collect all merchant details
	 *@author Dev-102
	 *@param String $currency_iso Currency ISO Code
	 *@return array $merchant_details Merchant Configuration details
	 */	

	public function getMerchantDetails($currency_iso)
	{
		$merchant_details = array();
		$order_total = floatval(number_format($this->context->cart->getOrderTotal(true,3), 2, '.', ''));

		$SQL = "SELECT * FROM "._DB_PREFIX_.$this->module->name." WHERE `currency` = '".$currency_iso."' AND `min_amount` <= ".$order_total." AND `max_amount` >= ".$order_total;		

		$result = Db::getInstance()->executeS($SQL);
		foreach($result as $key=>$merchant)
		{
			$merchant_details['merchant_id'] = $merchant['merchant_id'];
			$merchant_details['terminals'][$merchant['member_id']] = $merchant['terminal_name'];
		}
		return $merchant_details;
	}	
}