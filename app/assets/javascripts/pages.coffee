# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  if $('.current-heading')[0]
    $('html, body').animate { scrollTop: $('#current').offset().top - 55 }, 0
  return
