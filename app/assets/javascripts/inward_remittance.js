$(document).ready(function(){ 
  $("a.verify-link").on("click", function () {
    $(".id_type").text("Verify Identity : " + $(this).data('id-type') + " " + $(this).data('id-number'));
    $("#whitelisted_identity_partner_id").val($(this).data('partner-id'));
    $("#whitelisted_identity_full_name").val($(this).data('full-name'));
    $("#whitelisted_identity_first_name").val($(this).data('first-name'));
    $("#whitelisted_identity_last_name").val($(this).data('last-name'));
    $("#whitelisted_identity_id_type").val($(this).data('id-type'));
    $("#whitelisted_identity_id_number").val($(this).data('id-number'));
    $("#whitelisted_identity_id_country").val($(this).data('id-country'));
    $("#whitelisted_identity_id_expiry_date").val($(this).data('id-expiry-date'));
    $("#whitelisted_identity_id_issue_date").val($(this).data('id-issue-date'));
    $('#verifyIdentity').modal();
  });
});