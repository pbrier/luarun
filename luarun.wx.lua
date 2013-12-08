--
-- luarun.wx.lua
-- Peter Brier
-- Wrapper for wxlua to run a lua script in the current directory (main.wx.lua) or select one using a file selection dialog
-- Tested with wxLua-2.8.12.2-MSW-Unicode
--
-- Attach to wxluafreeze.exe to make a stand-alone executeable:
-- ..\bin\lua.exe ..\apps\wxluafreeze\wxluafreeze.lua ..\bin\wxLuaFreeze.exe luarun.wx.lua luarun.exe
--
-- Inside the script, you can use the return value to keep continuing a script: true = continue (call script again or ask for new lua script), false = stop
--
-- A number of very basic UI functions are exposed to the script to open a file, show a message of ask for a value
--

---
--- Open a FileDialog
--- if rw = nil: ask for a lua script file
--- if rw = 'r': File must exist
--- if rw = 'w': Ask for a new filename 
--- if rw contains 'o': prompt for overwrite
---
function askfile(caption, rw, filter, file, dir)
  filter = filter or  "All files (*)|*|Text files (*.txt)|*.txt";
  file = file or "";
  dir = dir or "";
  local options = wx.wxFD_OPEN + wx.wxFD_FILE_MUST_EXIST;
  if rw:find('w') then
    options = wx.wxFD_SAVE;
    if not caption then caption = "Select file to save.."; end;
  else
    if not caption then caption = "Select file to open.."; end;
  end;
  if rw:find('o') then options = options + wx.wxFD_OVERWRITE_PROMPT; end;
  
  local fileDialog = wx.wxFileDialog(wx.NULL, caption, dir, file, filter, options)
    if fileDialog:ShowModal() == wx.wxID_OK then
      if not  fileDialog:GetPath()  then
        wx.wxMessageBox("Unable to load file '"..fileDialog:GetPath().."'.", "wxLua Error", wx.wxOK + wx.wxCENTRE, wx.NULL)
      end
    else
      return nil;
    end
    local fn = fileDialog:GetPath();
    fileDialog:Destroy()
  return fn; 
end


-- Ask for a directory
function askdir(message, default)
  message = message or "Choose a directory";
  default = default or "";
  local d = wx.wxDirDialog(wx.NULL, message, default);
  d:ShowModal();
  dir = d:GetPath();
  d:Destroy();
  return dir;  
end;



-- As a value, with a modal dialog
function ask(value,default,caption)
  value = value or "";
  default = default or "";
  caption = caption or "Enter value for " .. value .. "...";
  local d = wx.wxTextEntryDialog(wx.NULL, value, caption, default);
  d:ShowModal();
  value = d:GetValue();
  d:Destroy();
  return value;
end;


-- Ask a question, return yes/no/cancel
function question(question)
  local d = wx.wxMessageDialog(wx.NULL, question, question, wx.wxYES_NO + wx.wxCANCEL + wx.wxCENTRE + wx.wxICON_QUESTION )
  local result = d:ShowModal()
  d:Destroy()
  if result == wx.wxID_CANCEL then
    return "cancel";
  elseif result == wx.wxID_YES then
    return "yes";
  elseif result == wx.wxID_NO then
    return "no";
  end
end;


--
-- Main body, repeat until the called script returns false or nil
-- 
repeat 
  scriptname = "main.wx.lua"; -- default filename
  fp = io.open(scriptname, "r");  -- open in current directory
  if not fp then -- or search in exe directory
    dir,file,ext = string.match(arg[0], "(.-)([^\\/]-%.?([^%.\\/]*))$")
    scriptname = dir .. scriptname;
    fp = io.open(scriptname);
  end;
  if not fp then
    scriptname = askfile("Select Lua script file...", "r", "Lua files (*.lua)|*.lua|Text files (*.txt)|*.txt|All files (*)|*");
  else
    fp:close();
  end;
  if scriptname then result = dofile(scriptname); end;
until not result or not scriptname;
            