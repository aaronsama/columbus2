jQuery ->
  $('a.reverse-geocode').on 'click', ->
    $(@).parent().spin()
    $(@).parent().find('a').css 'pointer-events', 'none'
  .on 'ajax:success ajax:error', ->
    $(@).parent().spin(false)
    $(@).parent().find('a').css 'pointer-events', 'all'