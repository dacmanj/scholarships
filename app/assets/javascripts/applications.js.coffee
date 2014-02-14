# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

delay = (ms, func) -> setTimeout func, ms


transcriptValid = (value, element) ->
  console.log("transcript")
  $("a.attached_transcript").length > 0 || $("#application_transcript").val() != ""

referenceValid = (value, element) ->
  console.log("ref")
  references > 0

count = 0
wc = =>
  count++
  return ' '

essayValid = (value,element) ->
  text = $(element).tinymce().getContent({format: "text"})
  text = text.replace /[\s]+/ig, wc
  words = count+1;
  count = 0
  console.log(words)
  return words < 1050

set_delete_transcript = (e) ->
  $("#delete_transcript").val(1);

jQuery.validator.addMethod "transcript", transcriptValid, "Transcript must be attached."
jQuery.validator.addMethod "reference", referenceValid, "You must obtain a reference."
jQuery.validator.addMethod "essay", essayValid, "Essay must be approximately a page (no more than 1000 words)."

glyph_ok = $("<i/>").addClass("glyphicon glyphicon-ok");
glyph_exclaimation = $("<i/>").addClass("glyphicon glyphicon-exclamation-sign");

$ ->

  $(".alert-dismissable").delay(10000).fadeOut("slow")

  flash_success = (msg) ->
    "<div class=\"alert alert-dismissable alert-success\"><a class=\"close\" data-dismiss=\"alert\">&times;</a><div id=\"flash_success\">#{msg}</div></div>"

  $('#flash-message').delegate '.alert-dismissable', 'autodismiss', () -> 
    window.setTimeout autodismiss, 2000

  $("#validate_application_button").click (e) ->
    tinyMCE.triggerSave()
    $("#application_reference_completed").removeAttr("disabled")
    valid = $("form").valid()
    $("#application_reference_completed").attr("disabled","disabled")
    if valid
      $("#sign_action_button").removeAttr("disabled","disabled")
      $("#application_status").html("<p>Application validated! You can now sign the application. <i class='glyphicon glyphicon-ok'/>")
    e.preventDefault()


  application_form = ($("main.applications").length == 1)
  signature_stamp = $("#application_signature_stamp").val()
  signed = signature_stamp? && signature_stamp != ""
  $("#sign_action_button").attr("disabled","disabled")
  submit_application = ->
    save_application
    $("#sign_action_button").click();

  enable_upload_button = (e) ->
    if $("#application_transcript").val() != ""
      $('#upload_transcript_button').removeAttr("disabled")
  $("#application_transcript").bind "change", enable_upload_button

  save_application = ->    
    tinyMCE.triggerSave()
    if $("#application_transcript").val() != ""
      return true

    valuesToSubmit = $("main.applications form").serialize()
    $.ajax({
      url: $('main.applications form').attr('action'),
      data: valuesToSubmit,
      type: "PUT",
      dataType: "JSON" 
    }).success (json) ->
      $("body").scrollTop(0);
      $("#flash_message").append(flash_success(I18n.t("application.message.save_success"))).delay(3000).fadeOut("slow")
    false

  if signed
    $("input,select,textarea").attr("disabled","true")
    $("#sign_action_button").removeAttr("disabled")

  errorPlace = (error, element) ->
    element.closest("div.form-group").addClass("error").attr("title",error.html()).tooltip("show")
    delay 2000, ->
      element.closest("div.form-group").tooltip("hide")

  errorHighlight = (element, errorClass, validClass) ->
    $(element).closest("div.form-group").addClass(errorClass)
    $(element).addClass(errorClass).removeClass(validClass)

  errorUnhighlight = (element, errorClass, validClass) ->
    $(element).closest("div.form-group").removeClass(errorClass).attr("title","").attr("data-original-title","")
    $(element).removeClass(errorClass).addClass(validClass)

  errorList = (e, validator) ->
    application_status = $("#application_status")
    application_status.html("<dl/>").append($("<p style='color:red'>Errors Detected </p>").append(glyph_exclaimation))
    application_status_dl = $("dl",application_status)
    $("sign_action_button").attr("disabled","disabled")

    for error in validator.errorList
      label = $(error.element).closest("div.form-group").find("label:first").text().replace("* ","")
      application_status_dl.append $("<dt data-id='#{error.element.id}' style='color: red'>#{label}</dt><dd>#{error.message}</dd>").click ->
        $("#"+$(this).attr("data-id")).focus()


  $('#save_action_button').click(save_application)
  $('#delete_transcript_button').click(set_delete_transcript)
  $('main.applications form').validate({ ignore: '', debug: true, errorPlacement: errorPlace, unhighlight: errorUnhighlight, highlight: errorHighlight, submitFunction: submit_application, invalidHandler: errorList, onsubmit:false, rules: { 'application[transcript]': {required:false; transcript:true }, 'application[reference][completed]': {required:false; reference:true}, 'application[essay]': {required:true; essay:true} } })