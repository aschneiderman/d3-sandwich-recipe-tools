{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:createInputForm': => @createInputForm()

  deactivate: ->
    @subscriptions.dispose()

  createInputForm: ->
    className = "code_play"
    fields =  [{name: "height", value: 40}, {name: "width", value: 40}]
    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText("  <form class=\"#{className}\">\n    <table class=\"input_table\">\n")
      for field in fields
        name = field.name
        capitalizedName = field.name.charAt(0).toUpperCase() + field.name.slice(1)
        value = field.value
        editor.insertText("      <tr><td>#{capitalizedName}</td><td><input name=\"#{name}\" type=\"text\" value=\"#{value}\"> </td></tr>\n")
    editor.insertText("    </table>\n  </form>\n")


# Now all I need to do is to convert the line below into an array of objects:
  # width = <i id="width">40</i>, height = <i id="height">40</i>, cellsize = <i id="cellsize">39</i>;
