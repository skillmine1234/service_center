$(document).ready(function() {

	$("#ic_customer_sc_backend_code").on("change", function () {
	  if ($(this).val() == 'PURATECH'){
		$('#ic_customer_fee_pct').val('');
		$('#ic_customer_fee_income_gl').val('');
		$('#ic_customer_max_overdue_pct').val('');
		$('#ic_customer_fcust_contact_email').val('');
		$('#ic_customer_cust_contact_mobile').val('');
		$('#ic_customer_ops_email').val('');
		$('#ic_customer_rm_email').val('');
		$('#ic_customer_fee_pct').prop('readOnly',true);
		$('#ic_customer_fee_income_gl').prop('readOnly',true);
		$('#ic_customer_max_overdue_pct').prop('readOnly',true);
		$('#ic_customer_cust_contact_email').prop('readOnly',true);
		$('#ic_customer_cust_contact_mobile').prop('readOnly',true);
		$('#ic_customer_ops_email').prop('readOnly',true);
		$('#ic_customer_rm_email').prop('readOnly',true);
	  }
	  else {
	    $('#ic_customer_fee_pct').prop('readOnly',false);
		$('#ic_customer_fee_income_gl').prop('readOnly',false);
		$('#ic_customer_max_overdue_pct').prop('readOnly',false);
		$('#ic_customer_cust_contact_email').prop('readOnly',false);
		$('#ic_customer_cust_contact_mobile').prop('readOnly',false);
		$('#ic_customer_ops_email').prop('readOnly',false);
		$('#ic_customer_rm_email').prop('readOnly',false);
	  }
	});
	
	  if ($("#ic_customer_sc_backend_code").val() == 'PURATECH'){
		$('#ic_customer_fee_pct').val('');
		$('#ic_customer_fee_income_gl').val('');
		$('#ic_customer_max_overdue_pct').val('');
		$('#ic_customer_fcust_contact_email').val('');
		$('#ic_customer_cust_contact_mobile').val('');
		$('#ic_customer_ops_email').val('');
		$('#ic_customer_rm_email').val('');
		$('#ic_customer_fee_pct').prop('readOnly',true);
		$('#ic_customer_fee_income_gl').prop('readOnly',true);
		$('#ic_customer_max_overdue_pct').prop('readOnly',true);
		$('#ic_customer_cust_contact_email').prop('readOnly',true);
		$('#ic_customer_cust_contact_mobile').prop('readOnly',true);
		$('#ic_customer_ops_email').prop('readOnly',true);
		$('#ic_customer_rm_email').prop('readOnly',true);
	  }
	  else {
	    $('#ic_customer_fee_pct').prop('readOnly',false);
		$('#ic_customer_fee_income_gl').prop('readOnly',false);
		$('#ic_customer_max_overdue_pct').prop('readOnly',false);
		$('#ic_customer_cust_contact_email').prop('readOnly',false);
		$('#ic_customer_cust_contact_mobile').prop('readOnly',false);
		$('#ic_customer_ops_email').prop('readOnly',false);
		$('#ic_customer_rm_email').prop('readOnly',false);
	  }

});