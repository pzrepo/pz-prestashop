
<h3>{l s='Pzprestashop' mod='pzprestashop'}</h3>

<form name="redirect-form" action="{$processingurl}" method="post" class="form-horizontal" id="redirect_form">
    <input type="hidden" value="{$toid}" name="toid">
    <input type="hidden" value="{$partenerid}" name="partenerid">
    <input type="hidden" value="{$totype}" name="totype">
    <input type="hidden" value="{$key}" name="key">
    <input type="hidden" value="{$ipaddr}" name="ipaddr">
    <input type="hidden" value="{$amount}" name="amount">
    <input type="hidden" value="{$orderid}" name="description">
    <input type="hidden" value="{$redirecturl}" name="redirecturl">         
    <input type="hidden" value="{$checksum}" name="checksum">
    <input type="hidden" value="{$firstname}" name="firstname">
    <input type="hidden" value="{$lastname}" name="lastname">
    
    <input type="hidden" value="{$TMPL_street}" name="TMPL_street">
    <input type="hidden" value="{$TMPL_city}" name="TMPL_city">
    <input type="hidden" value="{$TMPL_COUNTRY}" name="TMPL_COUNTRY">
    <input type="hidden" value="{$TMPL_state}" name="TMPL_state">
    <input type="hidden" value="{$TMPL_CURRENCY}" name="TMPL_CURRENCY">
    <input type="hidden" value="{$TMPL_zip}" name="TMPL_zip">
    <input type="hidden" value="{$TMPL_telno}" name="TMPL_telno">
    <input type="hidden" value="{$TMPL_telnocc}" name="TMPL_telnocc">
    <input type="hidden" value="{$TMPL_emailaddr}" name="TMPL_emailaddr">
    <input type="hidden" value="{$orderdescription}" name="orderdescription">
    <input type="hidden" value="{$terminalid}" name="terminalid">
	<input type="hidden" value="{$splitpzprestashopDetails}" name="splitDetail">
	<input type="hidden" value="{$pctype}" name="pctype">
    <input type="hidden" value="{$lang_iso}" name="lang_iso">     
</form>
<div style="text-align:center;">
    <img src="{$base_dir}modules/pzprestashop/ajax-loader.gif"  />
</div>   
<script>
$(document).ready(function(){
	$("#redirect_form").submit();
});
</script>