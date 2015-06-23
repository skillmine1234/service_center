$(document).ready(function(){
  
  $("#ecol_customer_val_method").on("change",function(){
    var val_method =  $(this).val();
    if (val_method == 'N'){
      $('#ecol_customer_val_token_1').val('N');
      $('#ecol_customer_val_token_1').prop('readOnly',true);
      $('#ecol_customer_val_token_2').val('N');
      $('#ecol_customer_val_token_2').prop('readOnly',true);
      $('#ecol_customer_val_token_3').val('N');
      $('#ecol_customer_val_token_3').prop('readOnly',true);
      $('#ecol_customer_val_txn_date').val('N');
      $('#ecol_customer_val_txn_date').prop('readOnly',true);
      $('#ecol_customer_val_txn_amt').val('N');
      $('#ecol_customer_val_txn_amt').prop('readOnly',true);
      $('#ecol_customer_val_ben_name').val('N');
      $('#ecol_customer_val_ben_name').prop('readOnly',true);
      $('#ecol_customer_val_rem_acct').val('N');
      $('#ecol_customer_val_rem_acct').prop('readOnly',true);
      $('#ecol_customer_return_if_val_fails').val('N');
      $('#ecol_customer_return_if_val_fails').prop('readOnly',true);
      $('#ecol_customer_file_upld_mthd').val('');
      $('#ecol_customer_file_upld_mthd').prop('readOnly',true);
    }
    else if (val_method == 'W'){
      $('#ecol_customer_file_upld_mthd').val('');
      $('#ecol_customer_file_upld_mthd').prop('readOnly',true);
    }
    else{
      $('#ecol_customer_val_token_1').prop('readOnly',false);
      $('#ecol_customer_val_token_2').prop('readOnly',false);
      $('#ecol_customer_val_token_3').prop('readOnly',false);
      $('#ecol_customer_val_txn_date').prop('readOnly',false);
      $('#ecol_customer_val_txn_amt').prop('readOnly',false);
      $('#ecol_customer_val_ben_name').prop('readOnly',false);
      $('#ecol_customer_val_rem_acct').prop('readOnly',false);
      $('#ecol_customer_return_if_val_fails').prop('readOnly',false);
      $('#ecol_customer_file_upld_mthd').prop('readOnly',false);
    }

  });
  
  
  if ($('#ecol_customer_val_method').val() == 'N'){
    $('#ecol_customer_val_token_1').val('N');
    $('#ecol_customer_val_token_1').prop('readOnly',true);
    $('#ecol_customer_val_token_2').val('N');
    $('#ecol_customer_val_token_2').prop('readOnly',true);
    $('#ecol_customer_val_token_3').val('N');
    $('#ecol_customer_val_token_3').prop('readOnly',true);
    $('#ecol_customer_val_txn_date').val('N');
    $('#ecol_customer_val_txn_date').prop('readOnly',true);
    $('#ecol_customer_val_txn_amt').val('N');
    $('#ecol_customer_val_txn_amt').prop('readOnly',true);
    $('#ecol_customer_val_ben_name').val('N');
    $('#ecol_customer_val_ben_name').prop('readOnly',true);
    $('#ecol_customer_val_rem_acct').val('N');
    $('#ecol_customer_val_rem_acct').prop('readOnly',true);
    $('#ecol_customer_return_if_val_fails').val('N');
    $('#ecol_customer_return_if_val_fails').prop('readOnly',true);
    $('#ecol_customer_file_upld_mthd').val('');
    $('#ecol_customer_file_upld_mthd').prop('readOnly',true);
  }
  else if ($('#ecol_customer_val_method').val() == 'W'){
    $('#ecol_customer_file_upld_mthd').val('');
    $('#ecol_customer_file_upld_mthd').prop('readOnly',true);
  }
  else{
    $('#ecol_customer_val_token_1').prop('readOnly',false);
    $('#ecol_customer_val_token_2').prop('readOnly',false);
    $('#ecol_customer_val_token_3').prop('readOnly',false);
    $('#ecol_customer_val_txn_date').prop('readOnly',false);
    $('#ecol_customer_val_txn_amt').prop('readOnly',false);
    $('#ecol_customer_val_ben_name').prop('readOnly',false);
    $('#ecol_customer_val_rem_acct').prop('readOnly',false);
    $('#ecol_customer_return_if_val_fails').prop('readOnly',false);
    $('#ecol_customer_file_upld_mthd').prop('readOnly',false);
  } 
  
  $("#ecol_customer_token_1_type").on("change",function(){
    var token_1_type =  $(this).val();
    if (token_1_type == 'N'){
      $('#ecol_customer_val_token_1').val('N');
      $('#ecol_customer_val_token_1').prop('readOnly',true);
      $('#ecol_customer_token_1_length').val(0);
      $('#ecol_customer_token_1_length').prop('readOnly',true);
    }
    else{
      $('#ecol_customer_val_token_1').prop('readOnly',false);
      $('#ecol_customer_token_1_length').prop('readOnly',false);
    }
  });
  
  if ($('#ecol_customer_token_1_type').val() == 'N'){
    $('#ecol_customer_val_token_1').val('N');
    $('#ecol_customer_val_token_1').prop('readOnly',true);
    $('#ecol_customer_token_1_length').val(0);
    $('#ecol_customer_token_1_length').prop('readOnly',true);
  }
  else{
    $('#ecol_customer_val_token_1').prop('readOnly',false);
    $('#ecol_customer_token_1_length').prop('readOnly',false);
  }
  
  $("#ecol_customer_token_2_type").on("change",function(){
    var token_2_type =  $(this).val();
    if (token_2_type == 'N'){
      $('#ecol_customer_val_token_2').val('N');
      $('#ecol_customer_val_token_2').prop('readOnly',true);
      $('#ecol_customer_token_2_length').val(0);
      $('#ecol_customer_token_2_length').prop('readOnly',true); 
    }
    else{
      $('#ecol_customer_val_token_2').prop('readOnly',false);
      $('#ecol_customer_token_2_length').prop('readOnly',false);
    }
  });
  
  if ($('#ecol_customer_token_2_type').val() == 'N'){
    $('#ecol_customer_val_token_2').val('N');
    $('#ecol_customer_val_token_2').prop('readOnly',true);
    $('#ecol_customer_token_2_length').val(0);
    $('#ecol_customer_token_2_length').prop('readOnly',true);
  }
  else{
    $('#ecol_customer_val_token_2').prop('readOnly',false);
    $('#ecol_customer_token_2_length').prop('readOnly',false);
  }
  
  $("#ecol_customer_token_3_type").on("change",function(){
    var token_3_type =  $(this).val();
    if (token_3_type == 'N'){
      $('#ecol_customer_val_token_3').val('N');
      $('#ecol_customer_val_token_3').prop('readOnly',true);
      $('#ecol_customer_token_3_length').val(0);
      $('#ecol_customer_token_3_length').prop('readOnly',true); 
    }
    else{
      $('#ecol_customer_val_token_3').prop('readOnly',false);
      $('#ecol_customer_token_3_length').prop('readOnly',false);
    }
  });
  
  if ($('#ecol_customer_token_3_type').val() == 'N'){
    $('#ecol_customer_val_token_3').val('N');
    $('#ecol_customer_val_token_3').prop('readOnly',true);
    $('#ecol_customer_token_3_length').val(0);
    $('#ecol_customer_token_3_length').prop('readOnly',true);
  }
  else{
    $('#ecol_customer_val_token_3').prop('readOnly',false);
    $('#ecol_customer_token_3_length').prop('readOnly',false);
  }
  
  
});