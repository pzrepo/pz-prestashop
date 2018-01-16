{capture name=path}
	<a href="{$link->getPageLink('order', true, NULL, "step=5")|escape:'html':'UTF-8'}" title="{l s='Go back to the Checkout' mod='pzprestashop'}">{l s='Checkout' mod='pzprestashop'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Pzprestashop' mod='pzprestashop'}
{/capture}

<h2>{l s='Order summary' mod='pzprestashop'}</h2>
<hr>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

<p class="alert alert-success">{l s='Thank you for shopping with us. Your credit card has been charged and your transaction is successful. We will be shipping your order to you soon.' mod='pzprestashop'}</p>
<div id="mymodule_block_home" class="box cheque-box" >
	<p>
		{l s='Your order is successful.' sprintf=$shop_name mod='pzprestashop'}
			<br/>- {l s='Amount' mod='pzprestashop'} <span class="price"><strong>{displayPrice price=$amount}</strong></span>
			<br/>- {l s='Order refrence code is:' mod='pzprestashop'}<span>{$desc}</span>
			<br/> <strong>{l s='Your order will be sent as soon as we receive payment.' mod='pzprestashop'}</strong>
			<br/>{l s='If you have questions, comments or concerns, please contact our' mod='pzprestashop'} <a href="{$link->getPageLink('contact', true)|escape:'html'}">{l s='expert customer support team' mod='pzprestashop'}</a>.
	</p>
</div>