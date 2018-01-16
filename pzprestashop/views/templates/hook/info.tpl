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
<img src="../modules/pzprestashop/logo.png" style="float:left; margin-right:15px; margin-top:-10px;"  width="200" height="70">
<p><br/><strong>{l s="This module allows you to make secure payments." mod='pzprestashop'}</strong><br/><br/></p>
</div>
<!-- BOF BLOCK CARD TYPE CONFIGURATION -->
<!-- EOF BLOCK CARD TYPE CONFIGURATION -->
<div id="card_type_new_row" style="display:none;">
	<ul>
		<li><input type="text" name="card_type_id[]" value="" required="required"></li>
		<li><input type="text" name="card_type_name[]" value="" required="required"></li>
		<li style="width:18%"><input type="file" value="" name="card_type_logo[]" accept="image/*"></li>
		<li>
			<button class="btn btn-default btn_remove_row pull-right" name="btnAddNew" value="1" type="button">
				{l s="Remove Row"}
			</button>
		</li>
	</ul>
</div>
<!-- BOF BLOCK PAYMENT TYPE CONFIGURATION -->
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
			<label class="control-label col-lg-3 required">{l s="Totype"}</label>
			<div class="col-lg-9">
				<input id="totype" class="" type="text" required="required" value="{Configuration::get('totype')}" name="totype">
				<p class="help-block"> {l s="Provided by pzprestashop. Do not change the value. It will be fixed for all transactions Accept only [0-9][A-Z][a-z]"} </p>
			</div>
		</div>
		
		
		
		<div class="form-group">
			<label class="control-label col-lg-3 required">{l s="Partner Id"}</label>
			<div class="col-lg-9">
				<input id="partenerid" class="" type="text" required="required" value="{Configuration::get('partenerid')}" name="partenerid">
				<p class="help-block"> {l s="Enter Partner Id"} </p>
			</div>
		</div>
		
		
		
		<div class="form-group">
			<label class="control-label col-lg-3 required">{l s="Test Url"}</label>
			<div class="col-lg-9">
				<input id="processingurl" class="" type="text" required="required" value="{Configuration::get('processingurl')}" name="processingurl">
				<p class="help-block"> {l s="URL where payment will be processed."} </p>
			</div>
		</div>
                        
                <div class="form-group">
                <label class="control-label col-lg-3 required">{l s="Live Url"}</label>
                <div class="col-lg-9">
                        <input id="liveurl" class="" type="text" value="{Configuration::get('liveurl')}" name="liveurl">
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
		
		
		
<!--
		<div class="form-group">
			<label class="control-label col-lg-3">{l s="Enter Partner Id"}</label>
			<div class="col-lg-9">
				<input id="partenerid" class="" type="text"  value="{Configuration::get('partenerid')}" name="partenerid">
				<p class="help-block"> {l s="Enter partner id provided by Pzprestashop"} </p>
			</div>
		</div>	
-->
		
		
		{*<div class="form-group">
			<label class="control-label col-lg-3">{l s="Merchant Id"}</label>
			<div class="col-lg-9">
				<input id="toid" class="" type="text"  value="{Configuration::get('toid')}" name="toid">
				<p class="help-block"> {l s="User Id .Accept only [0-9]."} </p>
			</div>
		</div>*}
                        
                        
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s="Merchant Id"}</label>
                                    <div class="col-lg-9">
                                        <input id="merchantid1" class="" type="text"  value="{Configuration::get('merchantid1')}" name="merchantid1">
                                        <p class="help-block"> {l s="User Id .Accept only [0-9]."} </p>
                                    </div>
                                </div>
	
		<div class="form-group">
			<label class="control-label col-lg-3">{l s="Test Mode"}</label>
			<div class="col-lg-9">
				<select name="test_mode" id="test_mode">
				<option value="Y" {if Configuration::get('test_mode') =="Y"}{l s="selected"}{/if} >{l s="Yes"}</option>
				<option value="N" {if Configuration::get('test_mode') =="N"}{l s="selected"}{/if}>{l s="No"}</option>	
				</select>
						
			</div>
		</div>
		
		
		<div class="form-group">
			<label class="control-label col-lg-3">{l s="Working Key"}</label>
			<div class="col-lg-9">
				<input id="key" class="" type="text"  value="{Configuration::get('key')}" name="key">
				<p class="help-block"> {l s="Key Accept [0-9][A-Z][a-z]"} </p>
			</div>
		</div>	
		{*<div class="form-group">
			<label class="control-label col-lg-3">{l s="Minimum Amount"}</label>
			<div class="col-lg-9">
				<input id="defaultMinimum" class="" type="text"  value="{Configuration::get('defaultMinimum')}" name="defaultMinimum">
				<p class="help-block"> {l s="Minimum Amount Accept [0-9]"} </p>
			</div>
		</div>*}
		{*<div class="form-group">
			<label class="control-label col-lg-3">{l s="Maximum Amount"}</label>
			<div class="col-lg-9">
				<input id="defaultMaximum" class="" type="text"  value="{Configuration::get('defaultMaximum')}" name="defaultMaximum">
				<p class="help-block"> {l s="Maximum Amount Accept [0-9]"} </p>
			</div>
		</div>*}
	</div>
	<div class="panel-footer">
		<button class="btn btn-default pull-right pzprestashop_form_submit_btn" name="btnSubmit" id="module_form_submit_btn" value="1" type="submit">
		<i class="process-icon-save"></i>{l s="Save"}</button>
	</div>
</div>
</form>