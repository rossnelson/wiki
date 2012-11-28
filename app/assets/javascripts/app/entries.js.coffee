aggregateList = (val)->
  list = $('.entry')
  val = val.toLocaleLowerCase()
  $.each(list, (index, entry)->

    text = $(entry).find('a').text().toLocaleLowerCase()

    if text.search(val) > -1
      $(entry).show()
    else
      $(entry).hide()

  )

$(document).ready ()->
  Wiki.init()

  $("#entry_search").bind('keyup', (e)->
    aggregateList($(e.target).val())
  )

  uploader = new qq.FineUploaderBasic(
    button: $("#uploader")[0]
    request:
      endpoint: "/asseters.json"
      params:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
    callbacks:
      onComplete: (id, fileName, responseJSON)-> 
        asset = new Wiki.Asset(responseJSON)
        view = new Wiki.AssetShow(model: asset)
        view.render()
  )

