$(document).ready(function(){

	$(".request-link").on("click", function () {
	  var request = $(this).data('request');
	  $(".request").text(request);
	  $('#requestText').modal();
	});

	$(".reply-link").on("click", function () {
	  var reply = $(this).data('reply');
	  $(".reply").text(reply);
	  $('#replyText').modal();
	});

	$(".fault-link").on("click", function () {
	  $('#faultText').modal();
	});
	
  var clip1 = new ZeroClipboard($("#d_clip_button1"));
  var clip2 = new ZeroClipboard($("#d_clip_button2"));
	
});