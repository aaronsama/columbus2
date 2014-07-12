spinnerOpts =
  lines: 13, # The number of lines to draw
  length: 0, # The length of each line
  width: 5, # The line thickness
  radius: 10, # The radius of the inner circle
  corners: 1, # Corner roundness (0..1)
  rotate: 0, # The rotation offset
  direction: 1, # 1: clockwise, -1: counterclockwise
  color: '#fff', # #rgb or #rrggbb or array of colors
  speed: 1, # Rounds per second
  trail: 60, # Afterglow percentage
  shadow: false, # Whether to render a shadow
  hwaccel: false, # Whether to use hardware acceleration
  className: 'spinner', # The CSS class to assign to the spinner
  zIndex: 2e9, # The z-index (defaults to 2000000000)
  #top: '0', # Top position relative to parent
  #left: '50%' # Left position relative to parent

jQuery ->
  $('a.reverse-geocode').on 'click', ->
    cell = $(@).parent()
    cell.append('<div class="loading-state"></div>')
    pos = cell.position()
    bottomTop = pos.top;
    bottomLeft = pos.left;

    cell.find('.loading-state').css
      top: bottomTop
      left: bottomLeft
      width: cell.outerWidth()
      height: cell.outerHeight()

    cell.find('.loading-state').spin(spinnerOpts)
    cell.find('a').css 'pointer-events', 'none'
  .on 'ajax:success ajax:error', ->
    cell = $(@).parent()
    cell.find('.loading-state').remove()

    cell.spin(false)
    cell.find('a').css 'pointer-events', 'all'