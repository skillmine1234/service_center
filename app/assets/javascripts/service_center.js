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
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(f_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(f_reason);
    $('#faultText').modal();
  });
  
  $("#aml_reset").on('click', function(){
    $('input#search_params_firstName').val('');
    $('input#search_params_idNumber').val('');
  })
});