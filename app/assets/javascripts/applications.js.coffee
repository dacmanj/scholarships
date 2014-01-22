# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

delay = (ms, func) -> setTimeout func, ms

$ ->

  $(".alert-dismissable").delay(10000).fadeOut("slow")

  flash_success = (msg) ->
    "<div class=\"alert alert-dismissable alert-success\"><a class=\"close\" data-dismiss=\"alert\">&times;</a><div id=\"flash_success\">#{msg}</div></div>"

  $('#flash-message').delegate '.alert-dismissable', 'autodismiss', () -> 
    window.setTimeout autodismiss, 2000

  application_form = ($("main.applications.edit").length == 1)
  signature_stamp = $("#application_signature_stamp").val();
  signed = signature_stamp? && signature_stamp != ""

  submit_application = ->
    save_application
    $("#sign_action_button").click();

  save_application = ->    
    if $("#application_transcript").val() != ""
      return true

    valuesToSubmit = $(this).serialize()
    $.ajax({
      url: $('main.applications.edit form').attr('action'),
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
    console.log(element)
    console.log($(element))    
    $(element).closest("div.form-group").removeClass(errorClass).attr("title","").attr("data-original-title","")
    $(element).removeClass(errorClass).addClass(validClass)


  $('#save_action_button').click(save_application);
#  $('main.applications.edit form').validate({ debug: true, errorPlacement: errorPlace, unhighlight: errorUnhighlight, highlight: errorHighlight, submitFunction: submit_application })