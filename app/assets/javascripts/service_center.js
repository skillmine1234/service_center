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
});