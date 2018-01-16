
{capture name=path}
	<a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html':'UTF-8'}" title="{l s='Go back to the Checkout' mod='pzprestashop'}">{l s='Checkout' mod='pzprestashop'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Bank-wire payment' mod='pzprestashop'}
{/capture}

{include file="$tpl_dir./breadcrumb.tpl"}

<h2>{l s='Order summary' mod='pzprestashop'}</h2>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if $nbProducts <= 0}
	<p class="warning">{l s='Your shopping cart is empty.' mod='pzprestashop'}</p>
{else}

<h3>{l s='Bank-wire payment' mod='pzprestashop'}</h3>
<form action="{$link->getModuleLink(pzprestashop', 'validation', [], true)|escape:'html'}" method="post">
<p>
	<img src="{$this_path_bw}logo.jpg" alt="{l s='pzprestashop' mod='pzprestashop'}" width="86" height="49" style="float:left; margin: 0px 10px 5px 0px;" />
	{l s='You have chosen to pay using Pymentz gateway.' mod='pzprestashop'}
	<br/><br />
	{l s='Here is a short summary of your order:' mod='pzprestashop'}
</p>
<p style="margin-top:20px;">
	- {l s='The total amount of your order is' mod='pzprestashop'}
	<span id="amount" class="price">{displayPrice price=$total}</span>
	{if $use_taxes == 1}
    	{l s='(tax incl.)' mod='pzprestashop'}
    {/if}
</p>
<p>
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
</p>
<p>
	{l s='Pymentz account information will be displayed on the next page.' mod='pzprestashop'}
	<br /><br />
	<b>{l s='Please confirm your order by clicking "I confirm my order".' mod='pzprestashop'}</b>
</p>
<p class="cart_navigation" id="cart_navigation">
	<input type="submit" value="{l s='I confirm my order' mod='pzprestashop'}" class="exclusive_large" />
	<a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html'}" class="button_large">{l s='Other payment methods' mod='pzprestashop'}</a>
</p>
</form>
{/if}