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
# Make font size increase in the tree view along with the editor's font size
#
# see https://github.com/atom/atom/issues/11905#issuecomment-224865625
#
# initial value
document.documentElement.style.fontSize = (atom.config.get('editor.fontSize') - 1) + 'px'
# update value
atom.config.onDidChange 'editor.fontSize', ({newValue}) ->
  document.documentElement.style.fontSize = (newValue - 1) + 'px'