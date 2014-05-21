# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  
  totalScore = () ->
    sum = 0
    essay = $("#score_essay").val()
    reference = $("#score_reference").val()
    academics = $("#score_academics").val()
    activities = $("#score_activities").val()
    lgbt_advocacy = $("#score_lgbt_advocacy").val()
    discretionary = $("#score_discretionary").val()
    scores = [essay,reference,academics,activities,lgbt_advocacy,discretionary]
    multipliers = [6/25,3/25,4/25,3/25,5/25,4/25]
    sum += score*multipliers[i] for score, i in scores
    $("#normalized_score").html(sum.toFixed(2))

  $(".scores select").change(totalScore)
  totalScore()