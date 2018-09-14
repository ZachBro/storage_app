# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#ST_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    $('.input-group-addon').css('background-color', '#e9ecef')
    $('.input-group-addon').css('border', '1px solid #ced4da')
    $('.input-group-addon').css('color', '#495057')
    return
  $('#RNR_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', true
    $('.input-group-addon').css('background-color', '#ffb683')
    $('.input-group-addon').css('border', '1px solid #f7a266')
    $('.input-group-addon').css('color', 'black')
    return
  $('#LT_button').click ->
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    $('.input-group-addon').css('background-color', '#2c3f48')
    $('.input-group-addon').css('border', '1px solid #212d33')
    $('.input-group-addon').css('color', 'white')
    return
  if $('#RNR_button').hasClass('active') == true
    $('.input-group-addon').css('background-color', '#ffb683')
    $('.input-group-addon').css('border', '1px solid #f7a266')
    $('.input-group-addon').css('color', 'black')
    return
  if $('#LT_button').hasClass('active') == true
    $('#ticket_details_attributes_0_room_num').prop 'disabled', false
    $('.input-group-addon').css('background-color', '#2c3f48')
    $('.input-group-addon').css('border', '1px solid #212d33')
    $('.input-group-addon').css('color', 'white')
    return
  return
