{CompositeDisposable} = require 'atom'

# Helper functions
capitalize = (name) -> name.charAt(0).toUpperCase() + name.slice(1)


module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:create-input-form': => @createInputForm()
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:add-italics-and-id': => @addItalicsAndID()

  deactivate: ->
    @subscriptions.dispose()

# TO DO: create a search-and-replace to add the tags and let you enter the pre class

  addItalicsAndID: ->
    # addItalicsAndID: for the copied text, inserts a new version where italics tags
    # have been added around every variable = value pair. The italics tags are used
    # by D3 Sandwich recipes to select the code value that should be updated. For example:
    #   width = <i id="width">40</i>, height = <i id="height">40</i>, cellsize = <i id="cellsize">39</i>;
    # (okay, I need to put in a real explanation at some point here  :-) )
    if editor = atom.workspace.getActiveTextEditor()
      text = atom.clipboard.read()

      # width = 40, height=40,cellsize = 39;
      #  width = <i id="width">40</i>, height = <i id="height">40</i>, cellsize = <i id="cellsize">39</i>;
        # italicIDs = code.match(/<i.*?\/i>/gim)
      text = text.replace(/\s*(\w*?)[,;]/gm, "<i>Kaboom! <\/i>")
      editor.insertText("#{text}\n")

  createInputForm: ->
    # createInputForm: Given a list of field names and values, produces the first draft of the input form
    className = "code_play"
    fields =  [{name: "height", value: 40}, {name: "width", value: 40}]
    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText("  <form class=\"#{className}\">\n    <table class=\"input_table\">\n")
      for field in fields
        editor.insertText("      <tr><td>#{capitalize(field.name)}</td><td><input name=\"#{field.name}\" type=\"text\" value=\"#{field.value}\"> </td></tr>\n")
      editor.insertText("      <tr><td></td><td><input type=\"button\" value=\"Update the Map\"  onClick=\"$1(\'#{className}\', this)\"> </td></tr>\n")
      editor.insertText("    </table>\n  </form>\n")



# Now all I need to do is to convert the line below into an array of objects:
  # width = <i id="width">40</i>, height = <i id="height">40</i>, cellsize = <i id="cellsize">39</i>;
