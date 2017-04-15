$(document).ready(function(){

  $('#sc_backend_response_code_fault_code').blur(function() {
    var code = $('#sc_backend_response_code_fault_code').val();
    $.ajax({
       url: "/sc_fault_codes/get_fault_reason",
       data: {fault_code: code},
       dataType: "script",
       success: function(response) { 
         console.log(response);
         $('#fault_reason').text('Fault Reason : ' + (response || 'not found'));
       }
    });
    
  });

});