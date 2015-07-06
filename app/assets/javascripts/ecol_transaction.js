$(document).ready(function(){
  
  $("#from_transfer_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-10:+70"
  });

  $("#to_transfer_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-10:+70"
  });
  
  $("#select_all").on("change",function(){
    $('.txn_select').prop("checked", $(this).prop("checked"));
  });
  $('.txn_select').prop("checked", $(this).prop("checked"));
  
});