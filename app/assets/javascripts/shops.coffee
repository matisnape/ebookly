# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('body').on 'click', '#create_btn', ->
    $('#shop-form').closest('tr').show()
  $('body').on 'click', '.cancel_btn', ->
    $('#shop-form').closest('tr').hide()
