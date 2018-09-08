# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#ST_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    return
  $('#RNR_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', true
    return
  $('#LT_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    return
  return
