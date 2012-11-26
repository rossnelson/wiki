aggregateList = (val)->
  list = $('.entry')
  val = val.toLocaleLowerCase()
  $.each(list, (index, entry)->

    text = $(entry).find('a').text().toLocaleLowerCase()

    if text.search(val) > -1
      console.log text
      $(entry).show()
    else
      $(entry).hide()

  )

appendAsset = ()->
  source = $("#asset-template").html()
  context = {"object_id" : new Date().getTime()}
  template = Handlebars.compile(source)

  $('.assets').append template(context)

$(document).ready ()->
  $("#entry_search").bind('keyup', (e)->
    aggregateList($(e.target).val())
  )

  $('.add-asset').bind 'click', (e)->
      appendAsset()
      false
