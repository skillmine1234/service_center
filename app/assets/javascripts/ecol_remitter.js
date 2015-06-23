$(document).ready(function(){
  
  $("#ecol_remitter_due_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: ":+70"
  });
  
  $("#ecol_remitter_customer_subcode").on("change",function(){
    var customer_subcode =  $(this).val();
    if (customer_subcode == ''){
      $('#ecol_remitter_customer_subcode_email').val('');
      $('#ecol_remitter_customer_subcode_email').prop('disabled',true);
      $('#ecol_remitter_customer_subcode_mobile').val('');
      $('#ecol_remitter_customer_subcode_mobile').prop('disabled',true);
    }
    else{
      $('#ecol_remitter_customer_subcode_email').prop('disabled',false);
      $('#ecol_remitter_customer_subcode_mobile').prop('disabled',false);
    }
  });
  
  if ($('#ecol_remitter_customer_subcode').val() == ''){
    $('#ecol_remitter_customer_subcode_email').val('');
    $('#ecol_remitter_customer_subcode_email').prop('disabled',true);
    $('#ecol_remitter_customer_subcode_mobile').val('');
    $('#ecol_remitter_customer_subcode_mobile').prop('disabled',true);
  }
  else{
    $('#ecol_remitter_customer_subcode_email').prop('disabled',false);
    $('#ecol_remitter_customer_subcode_mobile').prop('disabled',false);
  }
  
});