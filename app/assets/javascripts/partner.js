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
});