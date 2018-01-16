$(document).ready(function(){
	
	card_types_by_payment_type=[];
	
	$("#btn_add_new_row").click(function(){
		html = $("#new_row_html").html();
		$("#merchant-config").append(html);
	});
	$(".btn_remove_row").live("click",function(){
		$(this).closest("ul").remove();
	});
	$("#add_new_payment_type").click(function(){
		html = $("#payment_type_new_row").html();
		$("#payment_type_row").append(html);
	});
	$("#add_new_card_type").click(function(){
		html = $("#card_type_new_row").html();
		$("#card_type_config").append(html);
	});
	$("#manual").click(function(){
		$("#automatic_row").hide();
		$("#manual_row").show();

	});
	$("#automatic").click(function(){
		$("#manual_row").hide();
		$("#automatic_row").show();
	});
	$("#module_form_submit_btn").click(function(e){
		cardType = [];
		combinations = [];
		paymentType = [];
		cronType = [];
		$("#module_form .card_type").each(function() { 
			cardType.push($(this).val());
		});
		$("#module_form .payment_type").each(function() { 
			paymentType.push($(this).val());
		});	

		$("#module_form .cron_type").each(function() { 
			cronType.push($(this).val());
		});	
		var i=0;
		$("#module_form .terminal_id").each(function() {
			var terminal = $(this).val();
			if($.inArray(cardType[i]+"||"+terminal+paymentType[i],combinations) != -1)
			{
				alert("Some of your terminal & card type combinations are repeated.Please reset and try again.");			
				e.preventDefault();
				return;
			}			
			combinations.push(cardType[i]+"||"+terminal+"||"+paymentType[i]);
			i++;			
		});		
	});	
});