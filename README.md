luarun
======

wxLuaFreeze wrapper to make lua scripts run stand-alone

Wrapper for wxlua to run a lua script in the current directory (*main.wx.lua*) or select one using a file selection dialog if this file is not available.

Tested with wxLua-2.8.12.2-MSW-Unicode
Attach to wxluafreeze.exe to make a stand-alone executeable:
 `..\bin\lua.exe ..\apps\wxluafreeze\wxluafreeze.lua ..\bin\wxLuaFreeze.exe luarun.wx.lua luarun.exe`

Inside the main script, you can use the return value to keep continuing this script: true = continue (call script again or ask for new lua script), *false* or *nil* = stop, so it is basically embedded in a loop.

A number of very basic UI functions are exposed to the script to open a file, show a message of ask for a value
These all appear as modal dialog boxes.
* `ask("question", "default anwser", "caption")` -- Shows question dialog and return the awnser string
* `question("question")` -- shows yes/no/cancel dialog and return *"yes"*, *"no"* or *"cancel"* string
* `print("text")` -- Shows messagebox with text (standard wxlua functionality)
* `askfile("caption","mode","wildcard", "file", "dir")` -- Shows file-open dialog, return filename string. mode can be "r" or "w". Wildcard: "All|*|Text files|*.txt"
* `askdir("message", "default")` -- return directory name
* `textbox("value", edit, "caption")` -- Show a textbot, if edit=true, than the text value can be edited


And of course, all wxLua functions are available.

Inside the Executed script, you can use the return value to keep continuing a script: true = continue (call script again or ask for new lua script), false or nil = stop

