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
   
  $(".credit-link").on("click", function () {
    var c_status = $(this).data('credit-status');
    var c_result = $(this).data('credit-result');
    $(".credit_status").text(c_status);
    $(".credit_result").text(c_result);
    $('#creditText').modal();
  });
  
  $(".settle-link").on("click", function () {
    var s_result = $(this).data('settle-result');
    $(".settle_result").text(s_result);
    $('#settleText').modal();
  });
  
  $(".validation-link").on("click", function () {
    var v_result = $(this).data('validation-result');
    $(".validation_result").text(v_result);
    $('#validationText').modal();
  });
  
  $(".return-link").on("click", function () {
    var r_result = $(this).data('return-result');
    $(".return_result").text(r_result);
    $('#returnText').modal();
  });
  
  $(".val-request-link").on("click", function () {
    var request = $(this).data('request');
    $("div.request").text(request);
    $('#requestText').modal();
  });
  
  $(".val-reply-link").on("click", function () {
    var reply = $(this).data('reply');
    $("div.reply").text(reply);
    $('#replyText').modal();
  });
});