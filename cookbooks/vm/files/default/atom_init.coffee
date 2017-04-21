# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

#
# Make font size increase across in the tree view on the left
# See keymap.cson for the key bindings
#
# see https://github.com/atom/atom/issues/11905#issuecomment-224865625
#
UIFontSize = atom.config.get('editor.fontSize')
atom.commands.add 'atom-workspace',
  'ui:increase-font-size': ->
    UIFontSize += 1
    document.documentElement.style.fontSize = UIFontSize + 'px'
    @updateGlobalTextEditorStyleSheet()
  'ui:decrease-font-size': ->
    UIFontSize -= 1
    document.documentElement.style.fontSize = UIFontSize + 'px'
    @updateGlobalTextEditorStyleSheet()
  'ui:reset-font-size': ->
    UIFontSize = 12
    document.documentElement.style.fontSize = UIFontSize + 'px'
    @updateGlobalTextEditorStyleSheet()
