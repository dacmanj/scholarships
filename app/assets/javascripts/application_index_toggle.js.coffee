$ ->
  $('#select_all_application_id').change -> 
    $('input:checkbox[name^=application_id]').prop('checked',$(this).prop("checked"));
