window.Wiki = 
  Assets: {}
  init: ()->
    new Wiki.Router()
    Backbone.history.start({ pushState: true })
    @

Wiki.Router = Backbone.Router.extend(
  routes:
    "entries/:id/edit" : "index"

  index: ()->
    assets = new Wiki.Assets(window.assets)
    assets.render()
    @
)

Wiki.Asset = Backbone.Model.extend({
  urlRoot: '/asseters'
})

Wiki.Assets = Backbone.Collection.extend({
  url: '/asseters'

  render: ()->
    @each (model)->
      view = new Wiki.AssetShow(model: model)
      view.render()
  
})

Wiki.AssetShow = Backbone.View.extend({

  className: 'asset-wrap'

  initialize: ()->
    @model.bind('destroy', @remove, @)

  events:
    "click .remove"   : "trash"
    "click .url-insert" : "copyUrl"

  render: ()->
    self = @
    template = Handlebars.compile($('#asset-template').html())
    @.$el.html template(self.model.attributes)
    $('.assets').append self.el
    @el

  copyUrl: (e)->
    alert "[COPY ME]-> " + e.target.dataset.url

  trash: ()->
    @model.destroy()
})


