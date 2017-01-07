$(document).ready(function(){
  
  function get_rc_app(id) {
    $.ajax({
       url: "/rc_transfer_schedules/udfs/"+id,
       dataType: "script"
    });
  }

  $('#rc_transfer_schedule_rc_app_id').on('change',function(){
    get_rc_app($('#rc_transfer_schedule_rc_app_id').val());
  });

});