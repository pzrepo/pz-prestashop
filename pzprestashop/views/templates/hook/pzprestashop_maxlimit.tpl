<div class="" style="border: 1px solid black;">
<p class="payment_module">


	{*}<a href="#" title="{l s='Pay by pzprestashop' mod='pzprestashop'}">{/*}
	<form name="myForm" onsubmit="" action="{$link->getModuleLink('pzprestashop', 'validation', [], true)|escape:'html'}" method="post" class="form-horizontal" id="pzprestashopForm">
		<img src="{$this_path_bw}logo.jpg" alt="{l s='Pay by pzprestashop' mod='pzprestashop'}"/>
		<span class="payment-heading">{l s='Pay by Pzprestashop' mod='pzprestashop'}&nbsp;<span>{l s='(Cart Limit Exceeded.)' mod='pzprestashop'}</span></span>
		

			<div class="selection">
			<div class="payment-type">
			<span><label for="paymenttype" class="col-sm-3 control-label">{l s="Cart maximum limit reached,Please remove some products from cart." mod='pzprestashop'} </label></span>
			
			</div>
			
			</div>
		</form>
	{*}</a>{/*}
</p>
</div>
<style>
#pzprestashopForm .selection span {
    display: inline-block;

}
#pzprestashopForm .selection label {
    width: auto;
	 color: #ff9900;
}
#pzprestashopForm .selection div {
    padding: 15px 0 0;
}
#pzprestashopForm .payment-heading {
    color: #000000;
    font-size: 16px;
    font-weight: bold;
}
#pzprestashopForm .payment-heading > span {
    color: #777777;
}
#pzprestashopForm > img {
  padding: 0 4px 0 0;
}
#pzprestashopForm .payment-type label, .card-type label {
  font-size: 14px;
}
#pzprestashopForm .payment-type, .card-type {
  padding: 20px 0 0 80px !important;
  width: auto;
}
#pzprestashopForm .card-type label {
  padding-right: 45px;
}
#pzprestashopForm .payment-type select.select-card {
  border: 2px solid #c7d6db;
  border-radius: 3px;
  display: block;
  height: 30px;
}
</style>