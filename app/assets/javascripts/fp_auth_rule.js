$(document).ready(function(){
  $("#namesMoveRight,#namesMoveLeft").click(function(event) {
    var id = $(event.target).attr("id");
    var selectFrom = id == "namesMoveRight" ? "#names" : "#fp_auth_rule_operation_name";
    var moveTo = id == "namesMoveRight" ? "#fp_auth_rule_operation_name" : "#names";

    var selectedItems = $(selectFrom + " option:selected").toArray();
    $(moveTo).append(selectedItems);
    selectedItems.remove;
  });
	
	$('#fp_auth_rule_any_source_ip').change(function(event) {
		
  });
	
  $("#fp_auth_rule_any_source_ip").on("click",function(){
    if ($(this).attr('checked')) {
      $("#fp_auth_rule_source_ips").val('');
      $("#fp_auth_rule_source_ips").prop("disabled",true);
    }
    else {
      $("#fp_auth_rule_source_ips").prop("disabled",false);
    }
  });
	
  if ($("#fp_auth_rule_any_source_ip").attr('checked')) {
    $("#fp_auth_rule_source_ips").val('');
    $("#fp_auth_rule_source_ips").prop("disabled",true);
  }
  else {
    $("#fp_auth_rule_source_ips").prop("disabled",false);
  }

  $('#submit_fp_auth_rule').click(function(){
    var form = $(this).parent();
    $('#fp_auth_rule_operation_name option').each(function(i) {
      $(this).attr("selected", "selected");
    });
		
	});
});