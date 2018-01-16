$(document).ready(function(){  
	var country = $( "#TMPL_COUNTRY" ).val();
	
	if(window != window.parent)
	{
		$("#paymnetzForm").attr("target","_blank");
	}
	$("#paymenttype").change(function(){
		paymenttype = $(this).val();
		$.ajax({
			type : "post",
			url : baseDir + 'modules/pzprestashop/ajax.php',
			data : {paymenttype:paymenttype,action:'get_cards'},
			success : function(result) {
				$("#cardtype_config").html(result);
				$(".cardtype").trigger("change");
			}
		});
	});
	$("#paymenttype").trigger("change");
	$(".cardtype").live("change",function(){
		currency_iso = $("#TMPL_CURRENCY").val();
		card_type = $(this).val();
		$.ajax({
			type : "post",
			url : baseDir + 'modules/pzprestashop/ajax.php',
			data : {currency_iso:currency_iso,action:'get_terminal',card_type:card_type},
			success : function(result) {
				var json = $.parseJSON(result);
				$("#terminalid").val(json.terminal_id);
			}
		});
	});	
	//$(".cardtype").trigger("change");
});

	
