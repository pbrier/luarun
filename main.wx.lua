-- main.wx.lua
-- Sample script, to be used with luarun.exe
-- This script is automatically executed if it is in the same directory as the luarun.exe file
-- Luarun provides a number of very basic ui functions:
--
-- ask("question", "default anwser") -- Shows question dialog and return the awnser string
-- question("question") -- shows yes/no/cancel dialog and return "yes", "no" or "calcel" string
-- print("text") -- Shows messagebox with text (standard wxlua functionality)
-- askfile("caption","mode","wildcard") -- Shows file-open dialog, return filename string. mode can be "r" or "w". Wildcard: "All|*|Text files|*.txt"
-- askdir("caption") -- return directory name
-- textbox("text", edit, "caption") -- show multiline textbox. If edit is true, the text can be edited. The content is returned as a string
--

-- Examples:

-- print ( ask() );
-- print ( question("Quit?") );
-- wxlua.LuaStackDialog()
-- print( askfile("File to open...","*.txt"));
-- print( askfile("Text file to save...","wo","Text files|*.txt|All files|*"));
-- print( askdir("Input directory") );
print(arg[0] .. "\n" .. (arg[1] or ""));                     
print( textbox("Helloworld\n\nYes yes", true, "Edit the text"));
