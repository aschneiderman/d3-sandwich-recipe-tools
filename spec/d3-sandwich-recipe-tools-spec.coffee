D3SandwichRecipeTools = require '../lib/d3-sandwich-recipe-tools'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "D3SandwichRecipeTools", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('d3-sandwich-recipe-tools')

  describe "when the d3-sandwich-recipe-tools:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.d3-sandwich-recipe-tools')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'd3-sandwich-recipe-tools:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.d3-sandwich-recipe-tools')).toExist()

        d3SandwichRecipeToolsElement = workspaceElement.querySelector('.d3-sandwich-recipe-tools')
        expect(d3SandwichRecipeToolsElement).toExist()

        d3SandwichRecipeToolsPanel = atom.workspace.panelForItem(d3SandwichRecipeToolsElement)
        expect(d3SandwichRecipeToolsPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'd3-sandwich-recipe-tools:toggle'
        expect(d3SandwichRecipeToolsPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.d3-sandwich-recipe-tools')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'd3-sandwich-recipe-tools:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        d3SandwichRecipeToolsElement = workspaceElement.querySelector('.d3-sandwich-recipe-tools')
        expect(d3SandwichRecipeToolsElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'd3-sandwich-recipe-tools:toggle'
        expect(d3SandwichRecipeToolsElement).not.toBeVisible()
