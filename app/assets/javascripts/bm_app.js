$(document).ready(function(){

  if ($("#bm_app_is_configuration_global").attr('checked')) {
    disable_flex_fields('Y');
  }
  else {
    disable_flex_fields('N'); 
  }

  $("#bm_app_is_configuration_global").on("change",function(){
    if ($(this).attr('checked')) {
      disable_flex_fields('Y');
    } 
    else {
      disable_flex_fields('N'); 
    }
  });

  function disable_flex_fields(is_configuration_global_val) {
    var flex_user_id = $("#bm_app_flex_user_id");
    var flex_narrative_prefix = $("#bm_app_flex_narrative_prefix");
    

    var flex_user_id_lbl = $("#flex_user_id_lbl");
    var flex_narrative_prefix_lbl = $("#flex_narrative_prefix_lbl");

    var mandatory_mark = "*";

    if (is_configuration_global_val == 'Y') {
      $(flex_user_id).prop('disabled',true);
      $(flex_user_id_lbl).text($(flex_user_id_lbl).text().replace(mandatory_mark,''));

      $(flex_narrative_prefix).prop('disabled',true);
      $(flex_narrative_prefix_lbl).text($(flex_narrative_prefix_lbl).text().replace(mandatory_mark,''));
    }
    else {
      $(flex_user_id).prop('disabled',false);
      $(flex_user_id_lbl).text(mandatory_mark + $(flex_user_id_lbl).text());

      $(flex_narrative_prefix).prop('disabled',false);
      $(flex_narrative_prefix_lbl).text(mandatory_mark + $(flex_narrative_prefix_lbl).text());
    }
  }

});