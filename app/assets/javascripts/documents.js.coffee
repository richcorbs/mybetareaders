# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

getSelected = ->
  selected = ""
  if window.getSelection
    selected = window.getSelection().toString()
  else if document.getSelection
    selected = document.getSelection()
  else selected = document.selection.createRange().text  if document.selection

$(document).ready ->

  $ ->
    $(".paragraph").live "mouseup", ->
      paragraph_id = $(this).attr('data-paragraph-text-id')
      selected = getSelected()
      # SAVE HIGHLIGHT
      if selected.length > 0
        $('#comments_text_field_' + paragraph_id).val('\"' + selected + '\" ')
        $('#comments_text_field_' + paragraph_id).focus()


    $('blockquote.comment').click (event) ->
      paragraph_comment_id = $(this).attr("data-paragraph-comment-id")
      paragraph_id         = $(this).attr("data-paragraph-id")
      $.ajax
        type: "post"
        url: "/documents/writer_flag_paragraph"
        dataType: 'json'
        data: '&paragraph_comment_id=' + paragraph_comment_id
        success: (response) ->
          $('p#paragraph_comment_flag_' + paragraph_comment_id).html(response['comment'])
          $('span#paragraph_comment_flag_' + paragraph_id).html(response['paragraph'])

    $('.rating-star').click (event) ->
      stars       = $(this).attr("data-stars")
      feedback_id = $(this).attr("data-feedback-id")
      $.ajax
        type: "post"
        url: "/documents/feedback_rating"
        dataType: 'html'
        data: '&feedback_id=' + feedback_id + '&stars=' + stars
        success: (response) ->
          for i in [1..5]
            star = $('#star_' + feedback_id + '_' + i)
            # THIS LOGIC IS BECAUSE OF THE RTL I THINK
            if i >= stars
              if !star.hasClass('rated')
                star.addClass('rated')
            else
              if star.hasClass('rated')
                star.removeClass('rated')

    $('.bookmark-button').click (event) ->
      paragraph_id = $(this).attr("data-paragraph-id")
      $.ajax
        type: "post"
        url: "/paragraph_ratings/set_bookmark"
        dataType: 'html'
        data: '&paragraph_id=' + paragraph_id
        success: (response) ->
          if response == 'add'
            $('button.bookmark-button').each ->
              if $(this).hasClass('btn-success')
                $(this).removeClass('btn-success')
            $('#bookmark_button_' + paragraph_id).addClass('btn-success')
          else if response == 'remove'
            $('#bookmark_button_' + paragraph_id).removeClass('btn-success')

    $(".comment-button").click (event) ->
      event.preventDefault()
      form_id = $(this).attr("data-form-id")
      paragraph_id = $(this).attr("data-paragraph-id")

      if $('#comments_text_field_' + paragraph_id).val() != ''
        $.ajax
          type: "post"
          url: $("#" + form_id).attr("action")
          dataType: 'html'
          data: $("#" + form_id).serialize()
          success: (response) ->
            $('#comments_' + paragraph_id).append(response)
            $('#comments_' + paragraph_id).show()
            $('#comments_text_field_' + paragraph_id).val('')
            $('#comments_count_' + paragraph_id).text($('#comments_' + paragraph_id + ' > div.container').size())

    $("button.rate-criterium").click (event) ->
      event.preventDefault()
      button       = $(this)
      paragraph_id = $(this).attr("data-paragraph-id")
      criterium    = $(this).attr("data-criterium")
      direction    = $(this).attr("data-direction")
      form_id      = 'rating_buttons_form_' + paragraph_id
      form_data    = $("#" + form_id).serialize() + '&criterium=' + criterium + '&direction=' + direction + '&paragraph_id=' + paragraph_id
      $.ajax
        type: "post"
        url: "/paragraph_ratings/create_or_update"
        dataType: 'html'
        data: $("#" + form_id).serialize() + '&criterium=' + criterium + '&direction=' + direction + '&paragraph_id=' + paragraph_id
        success: ->
          if direction == 'up'
            if button.hasClass('btn-success')
              button.removeClass('btn-success')
            else
              button.addClass('btn-success')
            $('button#down_' + criterium + '_' + paragraph_id).removeClass('btn-danger')
          else
            if button.hasClass('btn-danger')
              button.removeClass('btn-danger')
            else
              button.addClass('btn-danger')
            $('button#up_' + criterium + '_' + paragraph_id).removeClass('btn-success')
      #    $('#comments_' + paragraph_id).append(response)
      #    $('#comments_text_area_' + paragraph_id).val('')
      #    $('#comments_count_' + paragraph_id).text($('#comments_' + paragraph_id + ' > blockquote').size())

    $("#book_icon_color").click (event) ->
      event.preventDefault()
      color     = $('#document_book_icon_color').val()
      new_color = ''
      switch color
        when 'green'
          new_color = 'blue'
        when 'blue'
          new_color = 'yellow'
        when 'yellow'
          new_color = 'orange'
        when 'orange'
          new_color = 'green'

      $('#document_book_icon_color').val(new_color)
      $('#book_icon').attr("src", '/assets/book-' + new_color + '.png');

    $('#document_book_icon_color').change (event) ->
      color = $('#document_book_icon_color').val()
      $('#book_icon').css('background-color', color)

    $('#text').keyup (event) ->
      text = $('#text').val()
      if text.length == 0
        word_count = 0
      else
        word_count = text.split(' ').length
      $('#word_count').text(word_count)
