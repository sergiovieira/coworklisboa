class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    "#{@get('current_comment')?.body}"

  ready: ->
    @currentIndex = 0
    @commentElem = $(@node).find('.comment-container')
    @qrcodeElem = $(@node).find('.qrcode')
    @qrcode = new QRCode(@qrcodeElem.get(0), { width: 75, height: 75, colorDark : "#000000", colorLight : "rgba(255,255,255,0)", correctLevel : QRCode.CorrectLevel.H })
    @nextComment()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextComment, 58000)

  updateQrcode: ->
    @qrcode.clear()
    if @current_comment.link_url
      console.log(@current_comment.link_url)
      @qrcodeElem.show()
      @qrcode.makeCode(@current_comment.link_url)
    else
      @qrcodeElem.hide()
	  
  nextComment: =>
    comments = @get('comments')
    if comments
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % comments.length
        @set 'current_comment', comments[@currentIndex]
        @updateQrcode()
        @commentElem.fadeIn()
