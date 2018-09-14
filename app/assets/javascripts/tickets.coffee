# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#ST_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    $('.input-group-addon').css('background-color', '#e9ecef')
    $('.input-group-addon').css('color', 'black')
    return
  $('#RNR_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', true
    $('.input-group-addon').css('background-color', '#FFB683')
    $('.input-group-addon').css('color', 'black')
    return
  $('#LT_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    $('.input-group-addon').css('background-color', '#2C3F48')
    $('.input-group-addon').css('color', 'white')
    return
  return
