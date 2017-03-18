$(document).ready(function(){
    
  $(".resend-link").on("click", function () {
    $('#resendPassword').modal().show();
  });

  $("#resend").on("click", function () {
    $('#resendPassword').hide();
  });
  
  $(".add-link").on("click", function () {
    $('#addUser').modal().show();
  });

  $("#add").on("click", function () {
    $('#addUser').hide();
  });

});
