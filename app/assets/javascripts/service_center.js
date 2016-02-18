$(document).ready(function(){
  $('.dropdown').hover(function(){
    $(this).find('.dropdown-menu').slideDown(100);
  }, function(){
    $(this).find('.dropdown-menu').slideUp(100);
  });

  window.setInterval(function(){
    $('.alert').fadeOut();
    $('.notice').fadeOut();
  }, 5000);

  $('h2.collapsible').click(function(){
    $(this).siblings('.collapsible-content').toggle();
  });

  $("a.request-link").on("click", function () {
    $('#requestText').modal();
  });

  $("a.reply-link").on("click", function () {
    $('#replyText').modal();
  });

  $("a.fault-link").on("click", function () {
    $('#faultText').modal();
  });

  $("a.result-link").on("click", function () {
    $('#resultText').modal();
  });

  $("a.active-link").on("click", function () {
    var f_code = $(this).data('fault-code');
    var f_reason = $(this).data('fault-reason');
    var f_subcode = $(this).data('fault-subcode');
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(f_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(f_reason);
    $(".modal-body .fault_subcode").text("");
    $(".modal-body .fault_subcode").text(f_subcode);
    $('#faultText').modal();
  });
  
  $("#aml_reset").on('click', function(){
    $('input#search_params_firstName').val('');
    $('input#search_params_idNumber').val('');
  });

  $("#ecol_remitter_reset").on('click', function(){
    $('input#customer_code').val('');
    $('input#customer_subcode').val('');
    $('input#remitter_code').val('');
  });

  $("#ecol_customer_reset").on('click', function(){
    $('input#code').val('');
    $('select#is_enabled').val('');
    $('input#credit_acct_val_pass').val('');
    $('input#credit_acct_val_fail').val('');
  });

  $("#ecol_transaction_reset").on('click', function(){
    $('input#transfer_unique_no').val('');
    $('input#customer_code').val('');
    $('select#status').val('');
    $('select#notification_status').val('');
    $('select#validation_status').val('');
    $('select#settle_status').val('');
    $('select#transfer_type').val('');
    $('input#bene_account_no').val('');
    $('input#from_transfer_timestamp').val('');
    $('input#to_transfer_timestamp').val('');
    $('input#from_amount').val('');
    $('input#to_amount').val('');
  });
	
  $("#bm_app_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_biller_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_bill_payment_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_aggr_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#imt_customer_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#imt_transfer_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
});