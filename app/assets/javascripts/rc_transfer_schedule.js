$(document).ready(function(){
  
  function get_rc_app(id) {
    $.ajax({
       url: "/rc_apps/"+id,
       dataType: "json",
       success: function(data){
         var i;
         if (data["udfs_cnt"] != 0) {
           for (i=1; i<= data["udfs_cnt"]; i++) {
             var name = data["udf"+i]["udf"+i+"_name"];
             var type = data["udf"+i]["udf"+i+"_type"];
             var field = '<div class="control-group">'+
                           '<label class="control-label" for="rc_transfer_schedule_udf'+i+'_">'+name+'</label>'+
                           '<input id="rc_transfer_schedule_udf'+i+'" name="rc_transfer_schedule[udf'+i+'_value]" type="'+type+'">'+
                           '<input id="rc_transfer_schedule_udf'+i+'_name" name="rc_transfer_schedule[udf'+i+'_name]" type="hidden" value="'+name+'">'+
                           '<input id="rc_transfer_schedule_udf'+i+'_type" name="rc_transfer_schedule[udf'+i+'_type]" type="hidden" value="'+type+'">'+
                         '</div>';
             $("#rc_transfer_schedule_form").find('.form-main').append(field);
           }
         }
       }
    });
  }

  $('#rc_transfer_schedule_rc_app_id').on('change',function(){
    get_rc_app($('#rc_transfer_schedule_rc_app_id').val());
  });

  if ($('#rc_transfer_schedule_rc_app_id').val() != '') {
    get_rc_app($('#rc_transfer_schedule_rc_app_id').val());
  }
  
});