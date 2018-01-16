{capture name=path}
	<a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html':'UTF-8'}" title="{l s='Go back to the Checkout' mod='pzprestashop'}">{l s='Checkout' mod='pzprestashop'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Pzprestashop' mod='pzprestashop'}
{/capture}

<h2>{l s='Order summary' mod='pzprestashop'}</h2>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if $nbProducts <= 0}
	<p class="warning">{l s='Your shopping cart is empty.' mod='pzprestashop'}</p>
{else}

<h3>{l s='Pzprestashop' mod='pzprestashop'}</h3>
<form name="myForm" onsubmit="" action="{$link->getModuleLink('pzprestashop', 'validation', [], true)|escape:'html'}" method="post" class="form-horizontal" id="paymnetzForm">
<div id="mymodule_block_home" class="box cheque-box">
	<p class="page-subheading">
		<img src="{$this_path_bw}logo.jpg" alt="{l s='pzprestashop' mod='pzprestashop'}" width="86" height="49" style="float:left; margin: 0px 10px 5px 0px;" />
		<br/>{l s='You have chosen to pay by Pzprestashop.' mod='pzprestashop'}		
		<br/>
	</p>
	<h4 style="margin-top:20px;">
		- {l s='The total amount of your order is' mod='pzprestashop'}
		<span id="amount" class="price">{displayPrice price=$total}</span>
		{if $use_taxes == 1}
	    	{l s='(tax incl.)' mod='pzprestashop'}
	    {/if}
	</h4>

		 <br/>
	    	<input type="hidden" value="{$toid}" name="toid">
	    	<input type="hidden" value="{$totype}" name="totype">
	    	<input type="hidden" value="{$key}" name="key">
	    	<input type="hidden" value="{$ipaddr}" name="ipaddr">
	    	<input type="hidden" value="{$total}" name="amount">
	    	<input type="hidden" value="{$orderid}" name="description">
	    	<input type="hidden" value="{$redirecturl}" name="redirecturl">	    	
	    	<input type="hidden" value="{$checksum}" name="checksum">
			<input type="hidden" value="{$firstname}" name="firstname">
			<input type="hidden" value="{$lastname}" name="lastname">
	        <input type="hidden" id="terminalid" name="terminalid" value="">
			{*}<input type="hidden" id="paymenttype" name="paymenttype" value="1">{/*}
		
	<!-- <p>
		-
		{if $currencies|@count > 1}
			{l s='We allow several currencies to be sent via pzprestashop.' mod='pzprestashop'}
			<br /><br />
			{l s='Choose one of the following:' mod='pzprestashop'}
			<select id="currency_payement" name="currency_payement" onchange="setCurrency($('#currency_payement').val());">
				{foreach from=$currencies item=currency}
					<option value="{$currency.id_currency}" {if $currency.id_currency == $cust_currency}selected="selected"{/if}>{$currency.name}</option>
				{/foreach}
			</select>
		{else}
			{l s='We allow the following currency to be sent via pzprestashop:' mod='pzprestashop'}&nbsp;<b>{$currencies.0.name}</b>
			<input type="hidden" name="currency_payement" value="{$currencies.0.id_currency}" />
		{/if}
	</p> -->
	<hr/>

	<h4 style="text-align: center;">	
		<b>{l s='Please fill below information to make payment.' mod='pzprestashop'}</b>
		<br/>
		<b>{l s='Those marked with * are Required fields. They cannot be left Un-Filled.' mod='pzprestashop'}</b>
	</h4>
	<br/>
	<div style="display:none"> <!-- START OF DISPLAY NONE DIV -->
	<div class="form-group"> 
		<div class="col-sm-6">
		<label for="textarea" class="col-sm-3 control-label">* {l s="Billing Address:" mod='pzprestashop'} </label>
			<textarea class="form-control" id="textarea" name="TMPL_street"  placeholder="Customer's Street" required>{$address}, {$address1}</textarea> 
		</div>
		<div class="col-sm-6">
		<label for="city" class="col-sm-3 control-label">* {l s="Billing City:" mod='pzprestashop'}</label>			
		 	<input class="form-control" id="city" type="text" name="TMPL_city" value="{$city}" placeholder"City" style="width: 100px" required="required"/> 
 		</div>
	</div>
	<br>
   <div class="form-group">
		<div class="col-sm-6" style="padding-top:8px;">	
	    <label for="countrycode" class="col-sm-3 control-label">* {l s="ISO Country Code:" mod='pzprestashop'}  </label>
        	<!--input class="form-control" id="TMPL_COUNTRY" type="text" name="TMPL_COUNTRY" value=""  placeholder="Ex: US"/-->        	
            <select name="TMPL_COUNTRY" id="TMPL_COUNTRY_ID" class="form-control" required>
                                <option value="">-</option>
                                {foreach from=$countries item=v}
                                <option value="{$v.iso_code}"{if (isset($country) AND $country == $v.id_country) OR (!isset($country) && $country == $v.id_country)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
                                {/foreach}
                            </select>

	    </div>

        <div class="col-sm-6">
		<label for="state" class="col-sm-3 control-label">{l s="Billing State:" mod='pzprestashop'}</label>		
            <span id="billing_state">
				{if (!empty($states))}
					<select name="TMPL_state" id="selectState" class="form-control">
						<option value="">-</option>
						{foreach from=$states item=v}
							<option value="{$v.iso_code}"{if (isset($state) AND $state == $v.id_state) OR (!isset($state) && $state == $v.id_state)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
						{/foreach}
					</select>
				{else}
					<input class="form-control" id="textState" type="text" name="TMPL_state"  placeholder="Enter state code."/>
				{/if}	
			<span> 

		</div>	    
	    {*<label for="TMPL_CURRENCY" class="col-sm-2 control-label">* {l s="Currency Symbol:" mod='pzprestashop'}  </label>
        <div class="col-sm-3" style="padding-top:8px;">	
        	<!-- input class="form-control" id="TMPL_CURRENCY" type="text" name="TMPL_CURRENCY" value=""  placeholder="Ex: USD"/ style="display:none;"> -->
        	<select  class="form-control" id="TMPL_CURRENCY" name="TMPL_CURRENCY" required>
        		<option value="">-</option>
                    {foreach from=$currencies item=v}
                        <option value="{$v.iso_code}"{if (isset($cust_currency) AND $cust_currency == $v.id_currency) OR (!isset($cust_currency) && $cust_currency == $v.id_currency)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
                    {/foreach}
        	</select>
        	
	    </div>*}
		<input id="TMPL_CURRENCY" type="hidden" name="TMPL_CURRENCY" value="{$currencyIsoCode}">
	</div>
	<div class="form-group">
    <div class="col-sm-6">	
		<label for="zipcode" class="col-sm-3 control-label">* {l s='Zip Code:' mod='pzprestashop'}</label>		
		 	<input class="form-control" id="zipcode"  type="text" name="TMPL_zip" value="{$postcode}" style="width: 100px"  placeholder="Ex: 400052 " required="required"/> 
		</div>
		<div class="col-sm-6">
	 	<label for="telno" class="col-sm-3 control-label">{l s='Telephone number:' mod='pzprestashop'}</label>
	 		 		<input class="form-control" id="telno" type="text" name="TMPL_telno"  value="{$phone}" placeholder="Ex: 226370256 "/> 
	 	</div>
	</div>
	<div class="form-group"> 
	<div class="col-sm-6">
	<label for="telno1" class="col-sm-3 control-label" > {l s='Telephone number Country code:' mod='pzprestashop'} </label>		
			<input class="form-control" id="telno1" type="text" name="TMPL_telnocc" style="width: 100px;" placeholder="Ex:091" /> 
		</div>
		<div class="col-sm-6">
		<label for="emailid" class="col-sm-3 control-label" >*  {l s='Email ID:' mod='pzprestashop'}</label>		
			<input id="emailid" class="form-control" type="text" name="TMPL_emailaddr" value="{$email}" placeholder="Ex: abc@xyz.com " required="required"/> 
		</div>
	</div>	
	<hr/>
	</div> <!-- END OF DISPLAY NONE DIV -->
	<div class="form-group">
	<div class="col-sm-12" style="display:none">	
		<label for="orderdescription" class="col-sm-3 control-label"> {l s="Order Description:" mod='pzprestashop'} </label>	
			<textarea class="form-control" id="orderdescription" name="orderdescription"  placeholder="Add some description or note.">{$order_comments}</textarea> 
		</div>		
		<div class="col-sm-12" style="padding-top:8px;">	
		<label for="paymenttype" class="col-sm-3 control-label">{l s="Select Payment Type:" mod='pzprestashop'} </label>
		<div style="padding-top:8px;">
			<select id="paymenttype" name="paymenttype" class="form-control">
				{foreach $merchant_payment_types as $item=>$v}
					<option value='{$item}' {if $item == "1"}{l s="selected"}{/if}>{$v}</option>
				{/foreach}
			</select>
		</div>	
		</div>
		
		<div class="col-sm-12" style="padding-top:8px;">	
		<label for="cardtype" class="col-sm-3 control-label">{l s="Select Card Type:" mod='pzprestashop'} </label>
			<!--<select id="cardtype" name="cardtype" class="form-control" >-->
			<div style="padding-top:8px;">
				{foreach $merchant_card_types as $item=>$v}
					<input name="cardtype" type="radio" class="cardtype" value='{$item}' {if $item == "1"}{l s="checked"}{/if}>{$v.name}</option>
				{/foreach}
			</div>
			<!--</select>-->  
		</div>
	</div>
	</div>
	<br/>

	<p class="cart_navigation" id="">
		<input type="submit" value="{l s='Proceed to payment >' mod='pzprestashop'}" id="proceed_pzprestashop"class="button btn btn-default button-medium" style=" border-radius: 4px; padding: 11px 15px 10px 15px;" />
		<!-- <a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html'}" class="button-exclusive btn btn-default"><i class="icon-chevron-left"></i>
			{l s='Other payment methods' mod='pzprestashop'}
		</a> -->
	</p>
</form>
{/if}
{strip}

{/strip}