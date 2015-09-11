D3SandwichRecipeToolsView = require './d3-sandwich-recipe-tools-view'
{CompositeDisposable} = require 'atom'

module.exports = D3SandwichRecipeTools =
  d3SandwichRecipeToolsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @d3SandwichRecipeToolsView = new D3SandwichRecipeToolsView(state.d3SandwichRecipeToolsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @d3SandwichRecipeToolsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @d3SandwichRecipeToolsView.destroy()

  serialize: ->
    d3SandwichRecipeToolsViewState: @d3SandwichRecipeToolsView.serialize()

  toggle: ->
    console.log 'D3SandwichRecipeTools was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
