$ ->
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()