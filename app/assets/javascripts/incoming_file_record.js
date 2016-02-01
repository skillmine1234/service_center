$(document).ready(function(){
  $("#show_record_text").on("click", function () {
    var record_txt = $(this).data('record_txt');
    $("#record_txt").text("");
    $("#record_txt").text(record_txt);
    $('#recordText').modal();
  });

  $("#show_fault_text").on("click", function () {
    var fault_reason = $(this).data('fault_reason');
    var fault_code = $(this).data('fault_code');
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(fault_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(fault_reason);
    $('#faultText').modal();
  });

  $("#show_fault_bitstream").on("click", function () {
    var fault_bitstream = $(this).data('fault_bitstream');
    $("#fault_bitstream").text("");
    $("#fault_bitstream").text(fault_bitstream);
    $('#faultBitstream').modal();
  });
});