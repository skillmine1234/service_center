$(document).ready(function(){

  if($('#ft_purpose_code_allowed_transfer_type').val() == 'APBS'){
		$('#ft_purpose_code_allow_only_registered_bene').prop("checked",false);
    $('#ft_purpose_code_allow_only_registered_bene').prop('disabled',true);
  }
	else {
		$('#ft_purpose_code_allow_only_registered_bene').prop('disabled',false);
	}

  $("#ft_purpose_code_allowed_transfer_type").on("change", function () {
    if ($(this).val() == 'APBS'){
  		$('#ft_purpose_code_allow_only_registered_bene').prop("checked",false);
      $('#ft_purpose_code_allow_only_registered_bene').prop('disabled',true);
    }
  	else {
  		$('#ft_purpose_code_allow_only_registered_bene').prop('disabled',false);
  	}
  });
});