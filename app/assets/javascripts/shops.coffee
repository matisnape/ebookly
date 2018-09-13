# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('body').on 'click', '#create_btn', ->
    $('#shop-form').closest('tr').show()
  $('body').on 'click', '.cancel_btn', ->
    $('#shop-form').closest('tr').hide()

#replace content in tr with input and add original value in input fields
  $('.edit_btn').on 'click', ->
    $(this).closest('tr').children('td:not(:last)').each ->
      cell_value = $.trim($(this).text())
      $(this).html("<input class='input-small' type='text' size='30'></input>")
      $(this).children('input').val(cell_value)
    $(this).removeClass('edit_btn')
    $(this).addClass('save_btn')
    $(this).text('Save')
    $(this).parent().find('.delete_btn')
      .addClass('hide')
    $(this).parent().find('.cancel_btn')
      .removeClass('hide')

