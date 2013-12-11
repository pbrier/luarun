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

--print ( ask() );
--print ( question("Quit?") );
-- wxlua.LuaStackDialog()
--print( askfile() );
--print( askfile("File to open..."));
--print( askfile("Text file to save...","wo","Text files|*.txt|All files|*"));
--print( askdir("Input directory") );
--print(arg[0] .. "\n" .. (arg[1] or ""));                     
--print( textbox("Helloworld\n\nYes yes", true, "Edit the text"));
-- Present a list of choices, and ask to select one

function check(choices, caption, default)
  caption = caption or "Please make a selection";
  default = default or 0;
  local choices = choices or  {"one", "two", "three", "four"}
  local s = wx.wxBoxSizer(wx.wxVERTICAL)

  local d = wx.wxDialog(wx.NULL, wx.wxID_ANY, caption, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxDEFAULT_DIALOG_STYLE+wx.wxRESIZE_BORDER+wx.wxMAXIMIZE_BOX+wx.wxMINIMIZE_BOX)
  
  local cb = {};
  for i,v in pairs(choices) do
    local checkObj = wxlua.wxLuaObject( { 0, 2 } );
    cb[v] = wx.wxCheckBox(d, wx.wxID_ANY, v,  wx.wxDefaultPosition, wx.wxDefaultSize, 0,  wx.wxGenericValidatorBool(checkObj)); 
    s:Add(cb[v], 3, wx.wxGROW + wx.wxALL, 6)
  end;
  
  d:SetSizer(s)
  s:SetSizeHints(d)   
  d:ShowModal();
  
  local value = {};
  for i,v in pairs(choices) do
    value[v] = cb[v]:GetValue();
   end;  
  d:Destroy();     
  return value;              
end;

c = check( {"a", "another long selection for a test", "b selection line", "c selection"},"my selection", 2 ) 

for i,v in pairs(c) do
  print(i,v ) ;
end;

