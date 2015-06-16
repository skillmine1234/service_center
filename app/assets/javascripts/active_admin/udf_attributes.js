$(document).ready(function(){
    $("#udf_attribute_control_type").on("change", function () {
        if ($('#udf_attribute_control_type').val() !=  "DropDown") {
            $('#udf_attribute_select_options').prop('disabled',true);
        } else {
            $('#udf_attribute_select_options').prop('disabled',false);
        }
    });
    
    
    $("#udf_attribute_data_type").on("change", function () {    
        if ($('#udf_attribute_data_type').val() !=  "Numeric") {
            $('#udf_attribute_min_value').prop('disabled',true);
            $('#udf_attribute_max_value').prop('disabled',true);
        } else {
            $('#udf_attribute_min_value').prop('disabled',false);
            $('#udf_attribute_max_value').prop('disabled',false);
        }
        if ($('#udf_attribute_data_type').val() !=  "String") {
            $('#udf_attribute_length').prop('disabled',true);
            $('#udf_attribute_min_length').prop('disabled',true);
            $('#udf_attribute_max_length').prop('disabled',true);
        } else {
            $('#udf_attribute_length').prop('disabled',false);
            $('#udf_attribute_min_length').prop('disabled',false);
            $('#udf_attribute_max_length').prop('disabled',false);
        }
    });
});