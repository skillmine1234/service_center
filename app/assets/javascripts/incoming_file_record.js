$(document).ready(function(){
  $(".show_record_text").on("click", function () {
    var record_txt = $(this).attr('data-record-txt');
    $("#record_txt").text("");
    $("#record_txt").text(record_txt);
    $('#recordText').modal();
  });

  $(".show_fault_text").on("click", function () {
    var fault_reason = $(this).attr('data-fault-reason');
    var fault_code = $(this).attr('data-fault-code');
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(fault_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(fault_reason);
    $('#faultText').modal();
  });

  $(".show_fault_bitstream").on("click", function () {
    var fault_bitstream = $(this).attr('data-fault-bitstream');
    $("#fault_bitstream").text("");
    $("#fault_bitstream").text(fault_bitstream);
    $('#faultBitstream').modal();
  });
});