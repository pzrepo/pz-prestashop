<style>
.form-group ul li {
    float: left;
    list-style-type: none;
    padding: 0 5px;
    width: 11%;
	margin : 2px 0;
}
.form-group ul {
   clear : both;
}
</style>
<div class="alert alert-info">
<img src="../modules/pzprestashop/logo.jpg" style="float:left; margin-right:15px;" width="86" height="49">
<p><br/><strong>{l s="This module allows you to make secure payments." mod='pzprestashop'}</strong><br/><br/></p>
</div>
<!-- BOF BLOCK CARD TYPE CONFIGURATION -->

<form method="post" action="" name="card_type_form" id="card_type_form" class="defaultForm form-horizontal" enctype="multipart/form-data">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-envelope"></i>{l s="Pzprestashop Card Type Details"}
		</div>
		<div class="form-group">
		<div id="card_type_config">
			<ul>
				<li><label class="control-label col-lg-12 required">{l s="Card Type ID"}</label></li>
				<li><label class="control-label col-lg-12 required">{l s="Card Type"}</label></li>
				<li><label class="control-label col-lg-12 required">{l s="Card Logo"}</label></li>
				<li><label class="control-label col-lg-12">{l s="Upload Logo"}</label></li>
			</ul>
			{foreach from=$card_type item=value}
				{if $value.card_type_id == ""}{continue}{/if}
				<ul>
					<li><input type="text" value="{$value.card_type_id}" name="card_type_id[]" required="required"></li>
					<li><input type="text" value="{$value.card_type_name}" name="card_type_name[]" required="required"></li>
					{*<li>
						<select name="payment_type_id[]">
							{foreach from=$payment_type item=val}
								<option value="{$val.payment_type_id}" {if $value.payment_type_id == $val.payment_type_id}{l s="selected"}{/if}>{$val.payment_type_name}</option>
							{/foreach}
						</select>	
					</li>*}
					
					<li>
					    {if $value.logo != ""}
					        {assign var='tmpNewimage' value=$logo_path|cat:$value.logo}
					        {if getimagesize($tmpNewimage)}<img src="{$tmpNewimage}"  style="width: 65px;height: 30px;margin-left: 24px;">{else}{$v.name}{/if}
					     {/if}
					</li>
					
					<li style="width:18%">
						<input type="hidden" name="existing_logo[]" value="{$value.logo}">
						<input type="file" value="" name="card_type_logo[]" accept="image/*"></span>
					</li>
					<li>
						<button class="btn btn-default btn_remove_row pull-right" name="btnAddNew" value="1" type="button">
							{l s="Remove Row"}
						</button>
					</li>
				</ul>
			{/foreach}
			{if empty($card_type)}
				<ul>
					<li><input type="text" value="" name="card_type_id[]" required="required"></li>
					<li><input type="text" value="" name="card_type_name[]" required="required"></li>
					{*<li>
						<select name="payment_type_id[]">
							<option value="">-</option>
							{foreach from=$payment_type item=value}
								<option value="{$value.payment_type_id}">{$value.payment_type_name}</option>
							{/foreach}
						</select>	
					</li>*}
					<li style="width:18%">						
						<input type="file" value="" name="card_type_logo[]" accept="image/*">		
					</li>
					<li>
						<button class="btn btn-default btn_remove_row pull-right" name="btnAddNew" value="1" type="button">
							{l s="Remove Row"}
						</button>
					</li>					
				</ul>
			{/if}
		</div>
		<div class="" style="clear:both;padding-top:10px;">
			<button class="btn btn-default pull-right" name="btnAddNew" id="add_new_card_type" value="1" type="button">
				{l s="Add New Row"}
			</button>
		</div>	
		</div>
		
		<div class="panel-footer">
			<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnCardTypeSubmit" id="btn_card_type" value="1" type="submit">
			<i class="process-icon-save"></i>{l s="Save"}</button>
		</div>
		
	</div>	
</form>
<!-- EOF BLOCK CARD TYPE CONFIGURATION -->
<div id="card_type_new_row" style="display:none;">
	<ul>
		<li><input type="text" name="card_type_id[]" value="" required="required"></li>
		<li><input type="text" name="card_type_name[]" value="" required="required"></li>
		{*<li>
			<select name="payment_type_id[]">
				<option value="">-</option>
				{foreach from=$payment_type item=value}
					<option value="{$value.payment_type_id}">{$value.payment_type_name}</option>
				{/foreach}
			</select>	
		</li>*}
		<li style="width:18%"><input type="file" value="" name="card_type_logo[]" accept="image/*"></li>
		<li>
			<button class="btn btn-default btn_remove_row pull-right" name="btnAddNew" value="1" type="button">
				{l s="Remove Row"}
			</button>
		</li>
	</ul>
</div>
<!-- BOF BLOCK PAYMENT TYPE CONFIGURATION -->
<form method="post" action="" name="payment_type_form" id="payment_type_form" class="defaultForm form-horizontal" enctype="multipart/form-data">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-envelope"></i>{l s="Pzprestashop Payment Type Details"}
		</div>
		<div class="form-group">
			<div id="payment_type_row">
			<ul>
				<li><label class="control-label col-lg-12 required">{l s="Payment Type ID"}</label></li>
				<li><label class="control-label col-lg-12 required">{l s="Payment Type"}</label></li>
				<li><label class="control-label col-lg-12 required">{l s="Card Requires"}</label></li>
			</ul>
			{foreach from=$payment_type item=value}
				<ul>
					<li><input type="text" name="payment_type_id[]" required="required" value="{$value.payment_type_id}"></li>
					<li><input type="text" name="payment_type_name[]" required="required" value="{$value.payment_type_name}"></li>
					<li>
						<select name="card_required[]" class="card_required">
							<option value="1" {if $value.card_required == "1"}{l s="selected"}{/if}>{l s="Yes"}</option>
							<option value="0" {if $value.card_required == "0"}{l s="selected"}{/if}>{l s="No"}</option>
						</select>
					</li>
					<li>
						<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
							{l s="Remove Row"}
						</button>
					</li>
				</ul>
			{/foreach}
			{if empty($payment_type)}
				<ul>
					<li><input type="text" name="payment_type_id[]" required="required" value=""></li>
					<li><input type="text" name="payment_type_name[]" required="required" value=""></li>
					<li>
						<select name="card_required[]" class="card_required">
							<option value="1" {l s="selected"}>{l s="Yes"}</option>
							<option value="0"}>{l s="No"}</option>
						</select>
					</li>
					<li>
						<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
							{l s="Remove Row"}
						</button>
					</li>
				</ul>
			{/if}
			</div>
			<div class="" style="clear:both;padding-top:10px;">
				<button class="btn btn-default pull-right" name="btnAddNew" id="add_new_payment_type" value="1" type="button">
					{l s="Add New Row"}
				</button>
			</div>		
		</div>
		<div class="panel-footer">
			<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnPaymentTypeSubmit" id="btn_payment_type" value="1" type="submit">
			<i class="process-icon-save"></i>{l s="Save"}</button>
		</div>		
	</div>
</form>

<!-- EOF BLOCK PAYMENT TYPE CONFIGURATION -->
<!-- BOF ADD NEW PAYMENT TYPE ROW -->
<div id="payment_type_new_row" style="display:none;">
	<ul>
		<li><input type="text" name="payment_type_id[]" required="required" value=""></li>
		<li><input type="text" name="payment_type_name[]" required="required" value=""></li>
		<li>
			<select name="card_required[]" class="card_required">
				<option value="1">{l s="Yes"}</option>
				<option value="0">{l s="No"}</option>
			</select>
		</li>
		<li>
			<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
				{l s="Remove Row"}
			</button>
		</li>
	</ul>
</div>
<!-- EOF ADD NEW PAYMENT TYPE ROW -->
<form method="post" name="" id="module_form" class="defaultForm form-horizontal" enctype="multipart/form-data">
<div class="panel">
	<div class="panel-heading">
		<i class="icon-envelope"></i>{l s="Pzprestashop Merchant account Details"}
	</div>
	<div class="form-wrapper">
		<div class="form-group">
			<label class="control-label col-lg-3 required">{l s="Name of Payment Service Provider"}</label>
			<div class="col-lg-9">
				<input id="totype" class="" type="text" required="required" value="{Configuration::get('totype')}" name="totype">
				<p class="help-block"> {l s="Provided by pzprestashop. Do not change the value. It will be fixed for all transactions Accept only [0-9][A-Z][a-z]"} </p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-lg-3 required">{l s="Processing URL"}</label>
			<div class="col-lg-9">
				<input id="processingurl" class="" type="text" required="required" value="{Configuration::get('processingurl')}" name="processingurl">
				<p class="help-block"> {l s="URL where payment will be processed."} </p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-lg-3">{l s="Merchant server IP Address"}</label>
			<div class="col-lg-9">
				<input id="ipaddr" class="" type="text"  value="{Configuration::get('ipaddr')}" name="ipaddr">
				<p class="help-block"> {l s="Merchant’s IP Address Ex: 127.127.127.127 Accept only [0-9] and ‘.’"} </p>
			</div>
		</div>		
	</div>
	<div class="form-group">
		<div id="merchant-config">			
			<ul>
			<!--	<li><label class="control-label col-lg-3 required">{l s="Seller ID"}</label></li> -->
				<li><label class="control-label col-lg-3 required">{l s="Merchant ID/Terminal ID"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Secret Key"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Terminal ID"}</label></li> 
				<li><label class="control-label col-lg-3 required">{l s="Payment Type"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Card Type"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Currency"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Minimum Amount"}</label></li>
				<li><label class="control-label col-lg-3 required">{l s="Maximum Amount"}</label></li>
				<li><label class="control-label col-lg-3">{l s="Action"}</label></li>
			</ul>
			{foreach from=$merchant_details item=value}
				<ul>
					<li><input type="text" name="toid[]" required="required" value="{$value.merchant_id}"></li>
					<li><input type="text" name="key[]" required="required" value="{$value.secret_key}"></li>
					<li><input type="text" name="terminal_id[]" class="terminal_id" required="required" value="{$value.terminal_id}"></li>
					{*}<li><input type="text" name="terminal_name[]" required="required" value="{$value.terminal_name}"></li>{/*}
					<li>
						<select name="payment_type[]" class="payment_type">
							{foreach from=$payment_type key=k item=v}
								<option value="{$v.payment_type_id|escape:'html':'UTF-8'}" {if $v.payment_type_id == $value.payment_type}{l s="selected"}{/if}>{$v.payment_type_name|escape:'html':'UTF-8'}</option>
							{/foreach}
						</select>
					</li>
					<li>
						<select name="card_type[]" class="card_type">
							{foreach from=$card_type key=k item=v}
								<option value="{$v.card_type_id|escape:'html':'UTF-8'}" {if $v.card_type_id == $value.card_type}{l s="selected"}{/if}>{$v.card_type_name|escape:'html':'UTF-8'}</option>
							{/foreach}
						</select>
					</li>					
					<li>
						<select name="currency[]">
							{foreach from=$currencies item=v}
								<option value="{$v.iso_code|escape:'html':'UTF-8'}" {if $value.currency == $v.iso_code}{l s="selected"}{/if}>{$v.name|escape:'html':'UTF-8'}</option>
							{/foreach}
						</select>
					</li>
					<li><input type="text" name="min_amount[]" required="required" value="{$value.min_amount}"></li>
					<li><input type="text" name="max_amount[]" required="required" value="{$value.max_amount}"></li>
					<li>
						<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
							{l s="Remove Row"}
						</button>
					</li>
				</ul>
			{/foreach}
			{if empty($merchant_details)} 
			<ul>
				<li><input type="text" name="toid[]" required="required"></li>
				<li><input type="text" name="key[]" required="required"></li>
				<li><input type="text" name="terminal_id[]" required="required" class="terminal_id"></li>
				{*}<li><input type="text" name="terminal_name[]" required="required"></li>{/*}
				<li>
					<select name="payment_type[]" class="payment_type">
						{foreach from=$payment_type key=k item=v}
							<option value="{$v.payment_type_id|escape:'html':'UTF-8'}">{$v.payment_type_name|escape:'html':'UTF-8'}</option>
						{/foreach}
					</select>
				</li>
				<li>
					<select name="card_type[]" class="card_type">
						{foreach from=$card_type key=k item=v}
							<option value="{$v.card_type_id|escape:'html':'UTF-8'}">{$v.card_type_name|escape:'html':'UTF-8'}</option>
						{/foreach}
					</select>
				</li>
				<li>
					<select name="currency[]">
						{foreach from=$currencies item=v}
							<option value="{$v.iso_code|escape:'html':'UTF-8'}">{$v.name|escape:'html':'UTF-8'}</option>
						{/foreach}
					</select>
				</li>
				<li><input type="text" name="min_amount[]" required="required" ></li>
				<li><input type="text" name="max_amount[]" required="required" ></li>
				<li>
					<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
						{l s="Remove Row"}
					</button>
				</li>
			</ul>
			{/if}
		</div>
		<div class="" style="clear:both;padding-top:10px;">
			<button class="btn btn-default pull-right" name="btnAddNew" id="btn_add_new_row" value="1" type="button">
				{l s="Add New Row"}
			</button>
		</div>
	</div>
	<div class="panel-footer">
		<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnSubmit" id="module_form_submit_btn" value="1" type="submit">
		<i class="process-icon-save"></i>{l s="Save"}</button>
	</div>
</div>
</form>
<!-- BOF ADD NEW ROW HTML -->
<div id="new_row_html" style="display:none;">
	<ul>
		<li><input type="text" name="toid[]" required="required"></li>
		<li><input type="text" name="key[]" required="required"></li>
		<li><input type="text" name="terminal_id[]" required="required" class="terminal_id"></li>
		{*}<li><input type="text" name="terminal_name[]"></li>{/*}
		<li>
			<select name="payment_type[]" class="payment_type">
				{foreach from=$payment_type key=k item=v}
					<option value="{$v.payment_type_id|escape:'html':'UTF-8'}">{$v.payment_type_name|escape:'html':'UTF-8'}</option>
				{/foreach}
			</select>
		</li>
		<li>
			<select name="card_type[]" class="card_type">
				{foreach from=$card_type key=k item=v}
					<option value="{$v.card_type_id|escape:'html':'UTF-8'}">{$v.card_type_name|escape:'html':'UTF-8'}</option>
				{/foreach}
			</select>
		</li>
		<li>
			<select name="currency[]">
				{foreach from=$currencies item=v}
					<option value="{$v.iso_code|escape:'html':'UTF-8'}">{$v.name|escape:'html':'UTF-8'}</option>
				{/foreach}
			</select>
		</li>
		<li><input type="text" name="min_amount[]" required="required"></li>
		<li><input type="text" name="max_amount[]" required="required"></li>
		<li>
			<button class="btn btn-default btn_remove_row" name="btnAddNew" value="1" type="button">
				{l s="Remove Row"}
			</button>
		</li>
	</ul>
</div>
<!-- EOF ADD NEW ROW HTML -->

<!-- BOF BLOCK PAYMENT TYPE CONFIGURATION -->
<form method="post" action="" name="cron_type_form" id="cron_type_form" class="defaultForm form-horizontal" enctype="multipart/form-data">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-envelope"></i>{l s="Cron Setting"}
		</div>
		<div class="form-group">
		
		
		       <div class="" style="clear:both;padding-top:10px;">
				<button class="btn btn-default pull-left" name="btnAddNew" id="manual" value="1" type="button">
					{l s="Manual"}
				</button>
				<button class="btn btn-default pull-left" name="btnAddNew" id="automatic" value="1" type="button">
					{l s="Automatic"}
				</button>
			</div>	

			<div id="manual_row" style="clear:both;padding-top:20px;">
				<div class="form-group" style="clear:both;padding-left:20px;">
					<!--<a href="../modules/pzprestashop/callcron.php"><button class="btn btn-default" name="btnruncron" type="button">
						{l s="Run"}</a>-->

					<button class="btn btn-default" name="btnruncron" id="btn_cron_type" value="1" type="submit">
					<i></i>{l s="Run"}</button>
				</div>					
			</div>

			<div id="automatic_row" style="display:none;clear:both;padding-top:20px;">
			        <div class="form-wrapper">
					<!--<div class="form-group">
						<label class="control-label col-lg-1">{l s="Command"}</label>
						<div class="col-lg-8">
							<input id="command" type="text" value="{Configuration::get('command')}" name="command">
							<p class="help-block"></p>
						</div>
					</div>-->
					<p class="help-block"> {l s="* Only fill the necessary fields"} </p>
				        <div class="form-group" style="clear:both;padding-left:15px;align:center;">
						<div class="col-lg-1">
							<!--<input id="min" type="text" value="{$min|escape:'htmlall':'UTF-8'}" name="min">
							<p class="help-block"> {l s="Min"} </p>
							<p class="help-block"> {l s="Ex: 0-59"} </p>-->
							
						</div>

						<div class="col-lg-1">
							<input id="hrs" type="text" value="{$hrs|escape:'htmlall':'UTF-8'}" name="hrs">
							<p class="help-block"> {l s="Hr"} </p>
							<p class="help-block"> {l s="Ex: 0-23"} </p>
						</div>

						<div class="col-lg-1">
							<input id="dayofmonth" type="text" value="{$dayofmonth|escape:'htmlall':'UTF-8'}" name="dayofmonth">
							<p class="help-block"> {l s="Day of Month"} </p>
							<p class="help-block"> {l s="Ex: 1-31"} </p>
						</div>

						<div class="col-lg-1">
							<input id="month" type="text" value="{$month|escape:'htmlall':'UTF-8'}" name="month">
							<p class="help-block"> {l s="Month"} </p>	
							<p class="help-block"> {l s="Ex: 1-12"} </p>
						</div>

						<div class="col-lg-1">
							<input id="dayofweek" type="text" value="{$dayofweek|escape:'htmlall':'UTF-8'}" name="dayofweek">
							<p class="help-block"> {l s="Day of Week"} </p>		
							<p class="help-block"> {l s="Ex: 1-6"} </p>
						</div>
					</div>
			</div>
		</div>		
		</div>
		<div class="panel-footer">
			<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnCronTypeSubmit" id="btn_cron_type" value="1" type="submit">
			<i class="process-icon-save"></i>{l s="Save"}</button>
		</div>		
	</div>
</form>

<!-- EOF BLOCK PAYMENT TYPE CONFIGURATION -->

<!-- BOF BLOCK PAYMENT Delay Days CONFIGURATION -->
<form method="post" action="" name="cron_delaydays_form" id="cron_delaydays_form" class="defaultForm form-horizontal" enctype="multipart/form-data">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-envelope"></i>{l s="Cron Days Setting"}
		</div>
		<div class="form-group">

			<div id="automatic_row" style="clear:both;padding-top:20px;">
			        <div class="form-wrapper">
					<p class="help-block"> {l s="* Only fill the necessary fields"} </p>
				        <div class="form-group" style="clear:both;padding-left:15px;align:center;">
						<div class="col-lg-1">
							<input id="days" type="text" value="{$days|escape:'htmlall':'UTF-8'}" name="days">
							<p class="help-block"> {l s="Days"} </p>
							<p class="help-block"> {l s="Ex: 0-9"} </p>
							
						</div>

					</div>
			</div>
		</div>		
		</div>
		<div class="panel-footer">
			<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnCronDaysSubmit" id="btnCronDaysSubmit" value="1" type="submit">
			<i class="process-icon-save"></i>{l s="Save"}</button>
		</div>		
	</div>
</form>

<!-- EOF BLOCK PAYMENT Delay Days CONFIGURATION -->