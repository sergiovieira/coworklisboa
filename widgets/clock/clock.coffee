class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 1000)
    moment.lang("pt")

  startTime: =>
    @set('time', moment().format('HH:mm:ss'))
    @set('date', moment().format('ll'))

  formatTime: (i) ->
    if i < 10 then "0" + i else i