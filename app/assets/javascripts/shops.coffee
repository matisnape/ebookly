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

# discard changes in tr when clicked cancel
  $('body').on 'click', '.cancel_btn', ->
    $(this).addClass('hide')
    $(this).parent().find('.delete_btn')
      .removeClass('hide')
    $(this).parent().find('.save_btn')
      .addClass('edit_btn')
      .removeClass('save_btn')
      .text('Edit')
    $(this).closest('tr').children('td:not(:last)').each ->
      $.trim($(this).children("input").val())


#get data from input fields and prepare params and send ajax request for update
  $('.save_btn').on 'click', ->
    slug = $(this).closest("tr").attr('id')
    params_hash = "slug=" + slug + "&"
    $(this).closest('tr').children('td:not(:last)').each ->
      cell_value = $.trim($(this).children("input").val())
      index = $(this).closest("tr").children("td").index($(this)) + 1
      key = $("#shops").find("th:nth-child(" + index + ")").text().toLowerCase()
      params_hash += "shop["+key+"]="+cell_value+"&"
    $.ajax({
      type: 'PUT'
      url: '/shops/'+slug
      data: params_hash
    })
