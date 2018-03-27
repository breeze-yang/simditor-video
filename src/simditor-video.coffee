class Simditor.VideoButton extends Simditor.Button
  @i18n =
    'zh-CN':
      videoLink: '视频链接'
      posterLink: '封面链接'
    'en-US':
      videoLink: 'Video Link'
      posterLink: 'Poster Link'

  name: 'video'

  icon: 'video'

  htmlTag: 'video'

  disableTag: 'pre, table'

  constructor: (args...) ->
    super args...
    if @editor.formatter._allowedAttributes.video == undefined
      @editor.formatter._allowedAttributes.video = []
    @editor.formatter._allowedAttributes.video.push('src', 'controls', 'poster')

  _init: (args...) ->
    super args...
    @editor.body.on 'click', 'video', (e) =>
      $video = $(e.currentTarget)
      @popover.show $video
      false

  render: (args...) ->
    super args...
    @popover = new Simditor.VideoPopover
      button: @

  _status: ->
    @popover.hide()

  command: ->
    range = @editor.selection.range()
    @editor.selection.range range
    $video = $('<video/>', {
      src: '',
      controls: 'controls',
      preload: 'none'
    })
    $newBlock = $('<p/>').append($video)
    range.insertNode $newBlock[0]
    @editor.selection.setRangeAfter $video, range
    @editor.trigger 'valuechanged'
    $video.click()

class Simditor.VideoPopover extends Simditor.Popover

  render: ->
    tpl = """
    <div class="video-settings">
      <div class="settings-field">
        <label>#{ @_t 'videoLink' }</label>
        <input class="video-src" type="text"/>
        <a class="btn-delete-video" href="javascript:;">
          <i class="simditor-icon-delete"/>
        </a>
      </div>
      <div class="settings-field">
        <label>#{ @_t 'posterLink' }</label>
        <input class="poster-src" type="text"/>
      </div>
    </div>
    """
    @el.addClass('video-popover')
      .append(tpl)
    @srcEl = @el.find '.video-src'
    @posterEl = @el.find '.poster-src'
    @deleteEl = @el.find '.btn-delete-video'

    @srcEl.on 'keyup', (e) =>
      return if e.which == 13
      @target.attr('src', @srcEl.val())
      @editor.inputManager.throttledValueChanged()

    @posterEl.on 'keyup', (e) =>
      return if e.which == 13
      @target.attr('poster', @posterEl.val())
      @editor.inputManager.throttledValueChanged()

    $([@srcEl[0], @posterEl[0]]).on 'keydown', (e) =>
      if e.which == 13 or e.which == 27
        e.preventDefault()
        range = document.createRange()
        @editor.selection.setRangeAfter @target, range
        @hide()
        @editor.inputManager.throttledValueChanged()

    @deleteEl.on 'click', (e) =>
      @target.remove()
      @hide()

  show: (args...) ->
    super args...
    @srcEl.val @target.attr('src')
    @posterEl.val @target.attr('poster')
    @srcEl.focus()

Simditor.Toolbar.addButton Simditor.VideoButton