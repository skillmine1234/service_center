$(document).ready(function(){
  
  $("#qg_ecol_todays_neft_txn_transfer_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-70:+70"
  });
  
  $('#qg_ecol_todays_neft_txn_transfer_date').datepicker("setDate", $('#qg_ecol_todays_neft_txn_transfer_date').val());
  
  $("#qg_ecol_todays_neft_txn_transfer_date").prop("readOnly",true);
  
});