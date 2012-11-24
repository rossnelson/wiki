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


$(document).ready ()->
  $("#entry_search").bind('keyup', (e)->
    aggregateList($(e.target).val())
  )

