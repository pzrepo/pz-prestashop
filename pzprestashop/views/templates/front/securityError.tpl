{capture name=path}
	<a href="{$link->getPageLink('order', true, NULL, "step=5")|escape:'html':'UTF-8'}" title="{l s='Go back to the Checkout' mod='pzprestashop'}">{l s='Checkout' mod='pzprestashop'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Pzprestashop' mod='pzprestashop'}
{/capture}

<h2>{l s='Order summary' mod='pzprestashop'}</h2>
<hr>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

<p class="alert alert-danger">
	{l s='Security error occurred.' sprintf=$shop_name mod='pzprestashop'} 
</p>

{*<div id="mymodule_block_home" class="box cheque-box" >
	<p>{l s='Your order is Declined.' sprintf=$shop_name mod='pzprestashop'}
		<br />- {l s='Amount' mod='pzprestashop'} <span class="price"><strong>{displayPrice price=$amount}</strong></span>
		<br />- {l s='Order refrence code is:' mod='pzprestashop'} {$desc}
		
		<br />{l s='We were unable to process your transaction as your form of payment was declined. Please review your details and try again. Alternatively, contact your bank or credit card company to resolve the matter. Thank you for using Cloud10.' mod='pzprestashop'} 
		<a href="{$link->getPageLink('contact', true)|escape:'html'}">{l s='expert customer support team' mod='pzprestashop'}</a>.
	</p>

	<!--<p>We were unable to process your transaction as your form of payment was declined. 
	Please review your details and try again. 
	Alternatively, contact your bank or credit card company to resolve the matter.
	Thank you for using Cloud10.</p>
</div>*}