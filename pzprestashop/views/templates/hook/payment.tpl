<div class="" style="border: 1px solid black;">
<p class="payment_module">


	{*}<a href="#" title="{l s='Pay by Cloud 10' mod='pzprestashop'}">{/*}
	<form name="myForm" onsubmit="" action="{$link->getModuleLink('pzprestashop', 'validation', [], true)|escape:'html'}" method="post" class="form-horizontal" id="paymnetzForm">
		<!--<img src="{$this_path_bw}logo.jpg" alt="{l s='Pay by pzprestashop' mod='pzprestashop'}"/>
		<span class="payment-heading">{l s='Pay by Cloud 10' mod='pzprestashop'}&nbsp;<span>{l s='(Highly trusted payment gateway.)' mod='pzprestashop'}</span></span>-->
		

			<input type="hidden" id="terminalid" name="terminalid" value="">
			<input type="hidden" id="TMPL_CURRENCY" name="TMPL_CURRENCY" value="{$TMPL_CURRENCY}">
			<div class="selection">
			
			<!--<div class="payment-type">
			<span><label for="paymenttype" class="col-sm-3 control-label">{l s="Select Payment Type:" mod='pzprestashop'} </label></span>
			<span><select id="paymenttype" name="paymenttype" class="select-card">
				{foreach $merchant_payment_types as $item=>$v}
					<option value='{$v.payment_type_id}' {if $v.payment_type_id == "1"}{l s="selected"}{/if}>{$v.payment_type_name}</option>
				{/foreach}
			</select></span>
			</div>
			
			<div class="card-type">
			<span style="float: left;"><label for="cardtype" class="col-sm-3 control-label" style="padding-top:0;">{l s="Select Card Type:" mod='pzprestashop'} </label></span>
			<span id="cardtype_config">	
				{foreach $merchant_card_types as $item=>$v}
					{if $item==""}{continue}{/if}
					<input name="cardtype" type="radio" class="cardtype" value='{$item}' {if $item == "1"}{l s="checked"}{/if}>
						{assign var='tmpNewimage' value=$logo_path|cat:$v.image}
						{if getimagesize($tmpNewimage)}<img width="86px;" height="49px;" src="{$tmpNewimage}">{else}{$v.name}{/if}
					<br>
				{/foreach}
			</span>
			<p style="text-align: right; padding: 0px 20px 0px 0px;">
				<input type="submit" value="{l s='Proceed to payment >' mod='pzprestashop'}" id="proceed_pzprestashop"class="button btn btn-default button-medium" style=" border-radius: 4px; padding: 11px 15px 10px 15px;" />
			</p>
			</div>
			-->
<p style="text-align: right; padding: 0px 20px 0px 0px;">
				<!--<input type="submit" value="{l s='Pay Now' mod='pzprestashop'}" id="proceed_pzprestashop"class="button btn btn-default button-medium" style=" border-radius: 4px; padding: 11px 15px 10px 15px;" />
				<img src="{$this_path_bw}logo.jpg" alt="{l s='Pay by pzprestashop' mod='pzprestashop'}"/>-->
				<button type="submit" height="50px" width="47px" id="proceed_pzprestashop" class="button btn btn-default" ><span><img src="{$this_path_bw}logo1.png" height="50px" alt="{l s='Pay by pzprestashop' mod='pzprestashop'}"/></span></button>
				
			</p>
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