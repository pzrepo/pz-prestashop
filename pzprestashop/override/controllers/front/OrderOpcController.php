<?php
class OrderOpcController extends OrderOpcControllerCore
{
	public $php_self = 'order-opc';
	public $isLogged;

	protected $ajax_refresh = false;

	/**
	 * Initialize order opc controller
	 * @see FrontController::init()
	 */
	public function init()
	{
		ParentOrderController::init();

		if (Tools::isSubmit('ajax'))
		{
			if (Tools::isSubmit('method'))
			{
				
				switch (Tools::getValue('method'))
				{
					case 'updateTOSStatus':
						if (Tools::isSubmit('checked'))
						{
							$this->context->cookie->checkedTOS = (int)Tools::getValue('checked');
						}
						exit;
						break;
						
					case 'makeFreeOrder':
						/* Bypass payment step if total is 0 */
						if (($id_order = $this->_checkFreeOrder()) && $id_order)
						{
							$order = new Order((int)$id_order);
							$email = $this->context->customer->email;
							if ($this->context->customer->is_guest)
								$this->context->customer->logout(); // If guest we clear the cookie for security reason

							$id_products_unique = array();
							$products = $order->getProducts();
							foreach($products as $product){
								$id_product = $product['product_id'];
								if (!in_array($id_product, $id_products_unique)){
									$id_products_unique[] = $id_product;
									$productCategories = Product::getProductCategories($id_product);
									if (in_array(Configuration::get('ID_CATEGORY_MAGAZINES'), $productCategories)){
										$redirectTo = $this->context->link->getModuleLink('magazines', 'MyMagazines', array(), true);
										$this->ajaxDie('freeorder|'.$order->reference.'|'.$email.'|'.$redirectTo);
									}
								}
							}
							$this->ajaxDie('freeorder|'.$order->reference.'|'.$email);
						}
						exit;
						break;
				}
			}
			else
				throw new PrestaShopException('Method is not defined');
		}
		parent::init();
	}
	
	/**
	 * Assign template vars related to page content
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{
		parent::initContent();

		// is free order?
		if ($this->context->cart->getOrderTotal() <= 0){
			$freeOrder = true;
		}else{
			$freeOrder = false;
		}
		$this->context->smarty->assign('freeOrder', $freeOrder);

	}
	
	// removed the check on TOS and moved to submit button
	protected function _getPaymentMethods()
	{
		if (!$this->isLogged)
			return '<p class="warning">'.Tools::displayError('Please sign in to see payment methods.').'</p>';
		if ($this->context->cart->OrderExists())
			return '<p class="warning">'.Tools::displayError('Error: This order has already been validated.').'</p>';
		if (!$this->context->cart->id_customer || !Customer::customerIdExistsStatic($this->context->cart->id_customer) || Customer::isBanned($this->context->cart->id_customer))
			return '<p class="warning">'.Tools::displayError('Error: No customer.').'</p>';
		$address_delivery = new Address($this->context->cart->id_address_delivery);
		$address_invoice = ($this->context->cart->id_address_delivery == $this->context->cart->id_address_invoice ? $address_delivery : new Address($this->context->cart->id_address_invoice));
		if (!$this->context->cart->id_address_delivery || !$this->context->cart->id_address_invoice || !Validate::isLoadedObject($address_delivery) || !Validate::isLoadedObject($address_invoice) || $address_invoice->deleted || $address_delivery->deleted)
			return '<p class="warning">'.Tools::displayError('Error: Please select an address.').'</p>';
		if (count($this->context->cart->getDeliveryOptionList()) == 0 && !$this->context->cart->isVirtualCart())
		{
			if ($this->context->cart->isMultiAddressDelivery())
				return '<p class="warning">'.Tools::displayError('Error: None of your chosen carriers deliver to some of the addresses you have selected.').'</p>';
			else
				return '<p class="warning">'.Tools::displayError('Error: None of your chosen carriers deliver to the address you have selected.').'</p>';
		}
		if (!$this->context->cart->getDeliveryOption(null, false) && !$this->context->cart->isVirtualCart())
			return '<p class="warning">'.Tools::displayError('Error: Please choose a carrier.').'</p>';
		if (!$this->context->cart->id_currency)
			return '<p class="warning">'.Tools::displayError('Error: No currency has been selected.').'</p>';
//		if (!$this->context->cookie->checkedTOS && Configuration::get('PS_CONDITIONS'))
//			return '<p class="warning">'.Tools::displayError('Please accept the Terms of Service.').'</p>';

		/* If some products have disappear */
		if (is_array($product = $this->context->cart->checkQuantities(true)))
			return '<p class="warning">'.sprintf(Tools::displayError('An item (%s) in your cart is no longer available in this quantity. You cannot proceed with your order until the quantity is adjusted.'), $product['name']).'</p>';

		if ((int)$id_product = $this->context->cart->checkProductsAccess())
			return '<p class="warning">'.sprintf(Tools::displayError('An item in your cart is no longer available (%s). You cannot proceed with your order.'), Product::getProductName((int)$id_product)).'</p>';

		/* Check minimal amount */
		$currency = Currency::getCurrency((int)$this->context->cart->id_currency);

		$minimal_purchase = Tools::convertPrice((float)Configuration::get('PS_PURCHASE_MINIMUM'), $currency);
		if ($this->context->cart->getOrderTotal(false, Cart::ONLY_PRODUCTS) < $minimal_purchase)
			return '<p class="warning">'.sprintf(
				Tools::displayError('A minimum purchase total of %1s (tax excl.) is required to validate your order, current purchase total is %2s (tax excl.).'),
				Tools::displayPrice($minimal_purchase, $currency), Tools::displayPrice($this->context->cart->getOrderTotal(false, Cart::ONLY_PRODUCTS), $currency)
			).'</p>';

		/* Bypass payment step if total is 0 */
		if ($this->context->cart->getOrderTotal() <= 0){
			return ' '; //do not use empty string!
			//return '<p class="center"><button class="button btn btn-default button-medium" name="confirmOrder" id="confirmOrder" onclick="confirmFreeOrder();" type="submit"> <span>'.Tools::displayError('I confirm my order.').'</span></button></p>';
		}else{
			$return = Hook::exec('displayPayment');
			if (!$return)
				return '<p class="warning">'.Tools::displayError('No payment method is available for use at this time. ').'</p>';
			return $return;
		}
			
		
	}
}

