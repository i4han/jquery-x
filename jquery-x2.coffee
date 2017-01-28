
class Event
   constructor: (e) ->
      @event = e
   isKey: (key, f) ->
      if __.isFunction f then (if key is (@event.keyCode or @event.which) then f() else true)
      else key is (@event.keyCode or @event.which)

window.event$ = (e) -> new Event e

$.fn.getStyle = -> switch
   when s = (_d = @get 0).currentStyle then __.reduce s, {}, (o, p) -> __.object o, p, s[p]
   when window.getComputedStyle        then __.reduce __.array(style = window.getComputedStyle _d, null), {}, (o, p) ->
      if '' is pValue = style.getPropertyValue(p) then o else __.object o, __.camelize(p), pValue
   else @css()

$.fn.copyStyle = (o) -> @css o.getStyle()

$.fn.editable = ->
   $input = $('<input type="text"></input>').css 'min-width', @width()
   submit = =>
      @html $input.val()
      @show()
      @trigger 'edited', [@html()]
      $(document).unbind 'click', cancel
      $input.detach()
   cancel = =>
      $input.off 'keyup'
      @show()
      $(document).unbind 'click', cancel
      $input.detach()
   $input.copyStyle @
   $input.css 'border-bottom': '2px solid black'
   $input.click (event) -> event.stopPropagation()
   @click (e) =>
      $input.val(@html()).insertBefore(@).focus()
         .keypress((e) -> event$(e).isKey 13, submit)
         .keyup    (e) -> event$(e).isKey 27, cancel
      @hide()
      setTimeout (-> $(document).click cancel), 1
   @
