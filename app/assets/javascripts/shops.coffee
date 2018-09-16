# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editOnClick = (data) ->
  $(data).closest('tr').children('td:not(:last)').each ->
    cell_value = $.trim($(this).text())
    $(this).children('span').addClass('hide')
    $(this).children('input').removeClass('hide').val(cell_value)
  $(data).removeClass('edit_btn')
  $(data).addClass('save_btn')
  $(data).text('Save')
  $(data).parent().find('.delete_btn')
    .addClass('hide')
  $(data).parent().find('.cancel_btn')
    .removeClass('hide')
  return

discardOnClick = (data) ->
  $(data).addClass('hide')
  $(data).parent().find('.delete_btn')
    .removeClass('hide')
  $(data).parent().find('.save_btn')
    .addClass('edit_btn')
    .removeClass('save_btn')
    .text('Edit')
  $(data).closest('tr').children('td:not(:last)').each ->
    $(this).children('span')
      .removeClass('hide')
    $(this).children('input')
      .addClass('hide')
  return

$(document).ready ->
  $('body').on 'click', '#create_btn', ->
    $('#shop-form').closest('tr').show()
  $('body').on 'click', '.cancel_form_btn', ->
    $('#shop-form').closest('tr').hide()

#replace content in tr with input and add original value in input fields
  $('.edit_btn').on 'click', ->
    editOnClick this

#discard changes in tr when clicked cancel
  $('body').on 'click', '.cancel_btn', ->
    discardOnClick this

  $('#shop-form').on 'ajax:success', (data) ->
    $('#shop-form')[0].reset()
    $('#shop-form').closest('tr').hide()
    $('body').on 'click', '.edit_btn', ->
      editOnClick this
    $('body').on 'click', '.cancel_btn', ->
      discardOnClick this
    return
  return

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
