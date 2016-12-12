# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# paginación ajax
$ ->
  if $('.pagination').length && $('#sports').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Loading more sports...")
        $.getScript(url)
    $(window).scroll()
    
    
    
    
    
#cargar img refile jax    
$ ->
  document.addEventListener 'trix-attachment-add', (event) ->
    attachment = event.attachment
    if attachment.file
      return sendFile(attachment)
    return

  document.addEventListener 'trix-attachment-remove', (event) ->
    attachment = event.attachment
    deleteFile attachment

  sendFile = (attachment) ->
    file = attachment.file
    form = new FormData
    form.append 'Content-Type', file.type
    form.append 'image[image]', file
    xhr = new XMLHttpRequest
    xhr.open 'POST', '/images', true

    xhr.upload.onprogress = (event) ->
      progress = undefined
      progress = event.loaded / event.total * 100
      attachment.setUploadProgress progress

    xhr.onload = ->
      response = JSON.parse(@responseText)
      attachment.setAttributes
        url: response.url
        image_id: response.image_id
        href: response.url

    xhr.send form

  deleteFile = (n) ->
    $.ajax
      type: 'DELETE'
      url: '/images/' + n.attachment.attributes.values.image_id
      cache: false
      contentType: false
      processData: false

  return    
  
  
  
  


#barra
jQuery ->
      $(document).on "upload:start", "form", (e) ->
        $(this).find("input[type=submit]").attr "disabled", true
        $("#progress-bar").slideDown('fast')

      $(document).on "upload:progress", "form", (e) ->
        detail          = e.originalEvent.detail
        percentComplete = Math.round(detail.loaded / detail.total * 100)
        $('.progress-bar').width("#{percentComplete}%");
        $("#progress-bar-text").text("#{percentComplete}% Complete")

      $(document).on "upload:success", "form", (e) ->
        $(this).find("input[type=submit]").removeAttr "disabled"  unless $(this).find("input.uploading").length
        $("#progress-bar").slideUp('fast')  