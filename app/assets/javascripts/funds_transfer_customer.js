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
	
  $('#funds_transfer_customer_form').bind('submit', function() {
      $(this).find(':input').removeAttr('disabled');
  });
});