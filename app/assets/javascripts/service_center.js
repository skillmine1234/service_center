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

  $("#adv_search_reset_button").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });

  $(".val-request-link").on("click", function () {
    var request = $(this).data('request');
    display_beautified_data(request, "div.request", "#requestText");
  });

  $(".val-reply-link").on("click", function () {
    var reply = $(this).data('reply');
    display_beautified_data(reply, "div.reply", "#replyText");
  });

  $(".val-fault-link").on("click", function () {
    var fault = $(this).data('fault');
    display_beautified_data(fault, "div.fault", "#faultLink");
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

  $("#submit_override").click(function(){
    $("#update_records").submit(function(){
      $("#submit_override").prop('disabled', true);
    });
  });

  $("#submit_skip").click(function(){
    $("#skip_records").submit(function(){
      $("#submit_skip").prop('disabled', true);
    });
  });

  $("#submit_restart").click(function(){
    $("#restart_records").submit(function(){
      $("#submit_restart").prop('disabled', true);
    });
  });
});

function beautify_xml(xml_string) {
  var beautified_xml_req, result;
  try {
    beautified_xml_req = vkbeautify.xml(xml_string);
  }
  catch (e) {
    beautified_xml_req = 'xml_parse_err';
  }
  return beautified_xml_req;
}

function beautify_json(json_string) {
  var beautified_json_req, result;
  try {
    beautified_json_req = vkbeautify.json(json_string);
  }
  catch (e) {
    beautified_json_req = 'json_parse_err';
  }
  return beautified_json_req;
}

function display_beautified_data(string, html_ele, modal){
  var xml_result = beautify_xml(string);
  if (xml_result != 'xml_parse_err') {
    $(html_ele).text(xml_result);  
  }
  else {
    var json_result = beautify_json(string);
    if (json_result != 'json_parse_err') {
      $(html_ele).text(json_result);  
    }
  }
  $(modal).modal();
}