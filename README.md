luarun
======

wxLuaFreeze wrapper to make lua scripts run stand-alone

Wrapper for wxlua to run a lua script in the current directory (main.wx.lua) or select one using a file selection dialog
Tested with wxLua-2.8.12.2-MSW-Unicode
Attach to wxluafreeze.exe to make a stand-alone executeable:
 ..\bin\lua.exe ..\apps\wxluafreeze\wxluafreeze.lua ..\bin\wxLuaFreeze.exe luarun.wx.lua luarun.exe

Inside the script, you can use the return value to keep continuing a script: true = continue (call script again or ask for new lua script), false = stop

A number of very basic UI functions are exposed to the script to open a file, show a message of ask for a value

ask("question", "default anwser") -- Shows question dialog and return the awnser string
question("question") -- shows yes/no/cancel dialog and return "yes", "no" or "calcel" string
print("text") -- Shows messagebox with text (standard wxlua functionality)
askfile("caption","mode","wildcard") -- Shows file-open dialog, return filename string. mode can be "r" or "w". Wildcard: "All|*|Text files|*.txt"
askdir("caption") -- return directory name

And of course, all wxLua functions are available.
