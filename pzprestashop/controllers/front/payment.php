<?php
class pzprestashopPaymentModuleFrontController extends ModuleFrontController
{
    public $ssl = true;
    public $display_column_left = false;

    public function initContent()
    {
        parent::initContent();
        $cart = $this->context->cart;
        if (!$this->module->checkCurrency($cart))
            Tools::redirect('index.php?controller=order');        
        $authorized = false;
        foreach (Module::getPaymentModules() as $module)
        {
            if ($module['name'] == 'pzprestashop')
            {
                if($this->checkModuleDispalyMode($cart))
                {
                    $authorized = true;
                    break;
                }
            }
        }
        if (!$authorized)
        {
            Tools::redirect($this->context->link->getPageLink('order','true'));
        }
            
        $address = new Address(intval($cart->id_address_delivery)); // get address details of the customer
        $customer = new Customer(intval($cart->id_customer)); // get customer details
        global $cookie;
        $currency = new CurrencyCore($cart->id_currency);   // get currency iso code
        $my_currency_iso_code = $currency->iso_code;
        $my_currency_rate = $currency->conversion_rate;

        $total = $cart->getOrderTotal(true, Cart::BOTH);
        $redirecturl = $this->context->link->getPageLink('index',true).'module/pzprestashop/redirecturl.php';
        $totype=Configuration::get('totype');
        
        $merchant_config = $this->getMerchantDetails($my_currency_iso_code);
		$merchant_terminals = $merchant_config['terminals'];
		$merchant_card_types = $merchant_config['card_type'];
		$merchant_payment_types = $this->getPaymentTypeName($merchant_config['payment_type'][0]);
				
		$toid = $merchant_config['merchant_id'];
		$key = $merchant_config['secret_key'];	
		$checksum = $merchant_config['checksum'];	
        
        $order = new Order();

        $orderid = $order->getUniqReference();
        $str = "$toid|$totype|$total|$orderid|$redirecturl|$key";
        $checksum = md5($str);

        if (Configuration::get('PS_RESTRICT_DELIVERED_COUNTRIES'))
            $countries = Carrier::getDeliveredCountries($this->context->language->id, true, true);
		    $countries = Carrier::getCustomerdetails($this->context->language->id, true, true);
        else
            $countries = Country::getCountries($this->context->language->id, true);
        	
        $states = State::getStatesByIdCountry($address->id_country);
        $currencies = Currency::getPaymentCurrencies($this->module->id);
        	
        $cart_message = "";
        $cart_message_array = Message::getMessagesByCartId($this->context->cart->id);
        if(isset($cart_message_array[0]['message']))
            $cart_message = $cart_message_array[0]['message'];
 
				
        $this->context->smarty->assign(array(
                'nbProducts' => $cart->nbProducts(),
                'cust_currency' => $cart->id_currency,
                'currency' => $cart->id_currency,
                'currencies' => $currencies,
                'total' => $total,
                'this_path' => $this->module->getPathUri(),
                'this_path_bw' => $this->module->getPathUri(),
                'totype'=> $totype,
                'ipaddr'=> Configuration::get('ipaddr'),
                'processingurl' => Configuration::get('processingurl'),
                'toid'=> $toid,
                'key'=> $key,
                'terminals' => $merchant_terminals,               
                'baseurl' => $redirecturl,
                'str' => $str,
                'checksum' => $checksum,
                'redirecturl' => $redirecturl,
                'currencyIsoCode' => $my_currency_iso_code,
                'currencyRate' => $my_currency_rate,
                'orderid' => $orderid,
                'firstname' => $address->firstname,
                'lastname' => $address->lastname,
                'city' => $address->city,
                'address' => $address->address1,
                'address1' => $address->address2,
                'country' => $address->id_country,
                'postcode' => $address->postcode,
                'phone' => ($address->phone_mobile != "")?$address->phone_mobile:$address->phone ,
                'countries' => $countries,
                'state' => $address->id_state,
                'states' => $states,
                'email' =>$this->context->customer->email,
                'order_comments' => $orderid,
        		'merchant_card_types' => $merchant_card_types,
        		'merchant_payment_types' => $merchant_payment_types,
        		'this_path' => $this->module->getPathUri(),
                'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->module->name.'/'
        ));
        $this->setTemplate('display.tpl');
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
            $merchant_details['secret_key'] = $merchant['secret_key'];
            $merchant_details['terminals'][] = $merchant['terminal_id'];
            $merchant_details['card_type'][$merchant['cartvalue']] = $this->getCardTypeName($merchant['card_type']);
            $merchant_details['payment_type'][] = $merchant['payment_type'];
			$merchant_details['paykent_configure'][] = $merchant['payment_conf'];
			$merchant_details['payment'][] = $merchant['payment'];
        }
        return $merchant_details;
    }
    
    /**
     *check the module availability
     *@author Dev-102
     *@param object $cart customer basket
     *@return bool $module_display_status module availability status
     */
    
    public function checkModuleDispalyMode($cart)
    {
        $currency = new CurrencyCore($cart->id_currency);
        $currency_iso_code = $currency->iso_code;
        $SQL = "SELECT * FROM `"._DB_PREFIX_.$this->module->name."` WHERE `currency` = '".$currency_iso_code."'";
        $merchant_details = Db::getInstance()->executeS($SQL);
        if(empty($merchant_details))
            return false;
        $total = floatval(number_format($cart->getOrderTotal(true,3), 2, '.', ''));
		$total = floatval(number_format($cart->getCustomerDetail(true,3), 2, '.', ''));
		$total = floatval(number_format($cart->getProductsDetail(true,3), 2, '.', ''));
        $module_display_status = false;
        foreach($merchant_details as $key=>$merchant_details)
        {
            if($total >= $merchant_details['max_amount'] && $total <=  $merchant_details['max_amount'])
            {
                $module_display_status = true;
                break;
            }
        }
        return $module_display_status;
    }
    
    /**
     * get card type display name
     * @author Dev-102
     * @param integer $card_type_id \
     * @return string $card_type Card type Name
     */
    public function getCardTypeName($card_type_id)
    {
    	$card_type = array("1"=>array("name"=>"VISA","image"=>"visa.png"),
						"2"=>array("name"=>"MASTER CARD","image"=>"master-card.jpg"),
						"3"=>array("name"=>"DINER","image"=>"diners.gif"),
						"4"=>array("name"=>"AMEX","image"=>"amex.jpg"),
						"5"=>array("name"=>"DISCOVER","image"=>"discover.gif"),
						"6"=>array("name"=>"CUP","image"=>"cup.jpg"));
    	return $card_type[$card_type_id];
    }

    public function getPaymentTypeName($card_type_id)
    {
    	$paymemt_type = array("1"=>"Credit Card");
    	return array("1"=>"Credit Card");
    }
    
}