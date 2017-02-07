$(document).ready(function(){
  if(!$('#partner_allow_imps').is(":checked")){
    $('#partner_mmid').prop('disabled',true)
    $('#partner_mobile_no').prop('disabled',true)
  }

  $("#partner_allow_imps").on("click", function () {
    if(!$('#partner_allow_imps').is(":checked")){
      $('#partner_mmid').val('');
      $('#partner_allow_imps').val('');
      $('#partner_mmid').prop('disabled',true)
      $('#partner_mobile_no').prop('disabled',true)
    }
    else{
      $('#partner_mmid').prop('disabled',false)
      $('#partner_mobile_no').prop('disabled',false)      
    }
  });

  $("#partner_notify_on_status_change").on("click", function () {
    if(!$('#partner_notify_on_status_change').is(":checked")){
      $('#partner_app_code').val('');
      $('#partner_app_code').prop('readOnly',true)
    }
    else{
      $('#partner_app_code').prop('readOnly',false)     
    }
  });
  
  if(!$('#partner_will_whitelist').is(":checked")){
    $('#partner_hold_for_whitelisting').prop('disabled',true)
  }

  $("#partner_will_whitelist").on("click", function () {
    if(!$('#partner_will_whitelist').is(":checked")){
      $('#partner_hold_for_whitelisting').prop('disabled',true)
    }
    else{
      $('#partner_hold_for_whitelisting').prop('disabled',false)
    }
  });

  if(!$('#partner_hold_for_whitelisting').is(":checked")){
    $('#partner_hold_period_days').prop('disabled',true)
  }

  $("#partner_hold_for_whitelisting").on("click", function () {
    if(!$('#partner_hold_for_whitelisting').is(":checked")){
      $('#partner_hold_period_days').prop('disabled',true)
    }
    else{
      $('#partner_hold_period_days').prop('disabled',false)
    }
  });
});