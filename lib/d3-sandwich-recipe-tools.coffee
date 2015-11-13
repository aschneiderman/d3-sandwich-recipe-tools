{CompositeDisposable} = require 'atom'

# Helper functions
capitalize = (name) -> name.charAt(0).toUpperCase() + name.slice(1)


module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:create-input-form': => @createInputForm()
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:add-italics-and-id': => @addItalicsAndIDtoVariables()
    @subscriptions.add atom.commands.add 'atom-workspace', 'd3-sandwich-recipe-tools:html-format-code': => @formatHTMLCode()
# formatHTMLCode
  deactivate: ->
    @subscriptions.dispose()


  addItalicsAndIDtoVariables: ->
    # addItalicsAndIDtoVariables: converts selected text so italics tags are added for every variables = value pair
    if editor = atom.workspace.getActiveTextEditor()
      text =  editor.getLastSelection().getText()
      editor.insertText( text.replace(/(\w*?)\s*\=\s*(\w*?)([,;])/gm, "$1 = <i id=\"$1\">$2<\/i>$3") )


  createInputForm: ->
    # createInputForm: Given a list of field names and values in the clipboard, produces the first draft of the input form
    # Example of what the code in the clipboard might look like:
    #    width = <i id="width">40</i>, height = <i id="height">40</i>, cellsize = <i id="cellsize">39</i>;
    className = "code_play"       # NOTE: placeholder until I write the code to pull from the pre-section
    if editor = atom.workspace.getActiveTextEditor()
      text = atom.clipboard.read()
      input_fields = text.match(/<i.*?<\/i>/g)
      form = "  <form class=\"#{className}\">\n    <table class=\"input_table\">\n"
      for field in input_fields
        [matchedText, name, value]  = /"(.*)"\s*>\s*(\w+)\s*</.exec field
        form = form + "      <tr><td>#{capitalize(name)}</td><td><input name=\"#{name}\" type=\"text\" value=\"#{value}\"> </td></tr>\n"
      form = form  + "      <tr><td></td><td><input type=\"button\" value=\"Update the Map\"  onClick=\"$1(\'#{className}\', this)\"> </td></tr>\n"
      form = form  + "    </table>\n  </form>\n"
      editor.insertText(form)

  formatHTMLCode: ->
  # html-format-code: Convert the D3 code stored in the clipboard into preformatted HTML and insert it
    return unless editor = atom.workspace.getActiveTextEditor()
    text = atom.clipboard.read()
    text = text.replace(/&/gm, "&amp")
    text = text.replace(/</gm, "&lt")
    text = text.replace(/>/gm, "&gt")
    editor.insertText("\n#{text}\n")
