$(document).ready(function(){
	
  if(!$('#funds_transfer_customer_allow_imps').attr('checked')){
		$('#funds_transfer_customer_mmid').val('');
    $('#funds_transfer_customer_mmid').prop('disabled',true);
  }
	else {
		$('#funds_transfer_customer_mmid').prop('disabled',false);
	}

  $("#funds_transfer_customer_allow_imps").on("click", function () {
    if (!$(this).attr('checked')){
      $('#funds_transfer_customer_mmid').val('');
      $('#funds_transfer_customer_mmid').prop('disabled',true);
    }
    else{
      $('#funds_transfer_customer_mmid').prop('disabled',false);      
    }
  });

  $("#funds_transfer_customer_is_retail").on("click", function () {
    if ($(this).attr('checked')){
      $('#funds_transfer_customer_customer_id').val('');
      $('#funds_transfer_customer_customer_id').prop('disabled',true);
    }
    else{
      $('#funds_transfer_customer_customer_id').prop('disabled',false);      
    }
  });
  
  if(!$('#funds_transfer_customer_allow_apbs').is(":checked")){
		$('#funds_transfer_customer_apbs_user_no').val('');
    $('#funds_transfer_customer_apbs_user_no').prop('readOnly',true);
		$('#funds_transfer_customer_apbs_user_name').val('');
    $('#funds_transfer_customer_apbs_user_name').prop('readOnly',true);
  }
	else {
		$('#funds_transfer_customer_apbs_user_no').prop('readOnly',false);
    $('#funds_transfer_customer_apbs_user_name').prop('readOnly',false);
	}

  $("#funds_transfer_customer_allow_apbs").on("click", function () {
    if (!$(this).is(":checked")){
  		$('#funds_transfer_customer_apbs_user_no').val('');
      $('#funds_transfer_customer_apbs_user_no').prop('readOnly',true);
  		$('#funds_transfer_customer_apbs_user_name').val('');
      $('#funds_transfer_customer_apbs_user_name').prop('readOnly',true);
    }
  	else {
  		$('#funds_transfer_customer_apbs_user_no').prop('readOnly',false);
      $('#funds_transfer_customer_apbs_user_name').prop('readOnly',false);   
    }
  });
	
  $('#funds_transfer_customer_form').bind('submit', function() {
      $(this).find(':input').removeAttr('disabled');
  });
});