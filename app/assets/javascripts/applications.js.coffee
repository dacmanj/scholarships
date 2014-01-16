# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $(".alert-dismissable").delay(10000).fadeOut("slow")

  flash_success = (msg) ->
    "<div class=\"alert alert-dismissable alert-success\"><a class=\"close\" data-dismiss=\"alert\">&times;</a><div id=\"flash_success\">#{msg}</div></div>"

  $('#flash-message').delegate '.alert-dismissable', 'autodismiss', () -> 
    window.setTimeout autodismiss, 2000

  application_form = ($("main.applications.edit").length == 1)
  signature_stamp = $("#application_signature_stamp").val();
  signed = signature_stamp? && signature_stamp != ""

  $('main.applications.edit form').submit () ->   
    if $("#application_transcript").val() != ""
      return true

    valuesToSubmit = $(this).serialize()
    $.ajax({
      url: $(this).attr('action'),
      data: valuesToSubmit,
      type: "POST",
      dataType: "JSON" 
    }).success (json) ->
      $("body").scrollTop(0);
      $("#flash_message").append(flash_success(I18n.t("application.message.save_success"))).delay(3000).fadeOut("slow")
    false

  if signed
    $("input,select,textarea").attr("disabled","true")
    $("#sign_action_button").removeAttr("disabled")
