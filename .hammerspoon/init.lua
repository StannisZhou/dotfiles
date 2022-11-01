-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Modal for normal mode
local normal = hs.hotkey.modal.new()

-- Enter normal mode
enterNormal = k:bind({""}, "n", nil, function()
    normal:enter()
    hs.alert.show('Normal mode')
    k.triggered = true
end)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Hot keys for opening various apps
cfun = function()
  hs.application.launchOrFocusByBundleID('com.google.Chrome')
  k.triggered = true
end
k:bind('', 'c', nil, cfun)

vfun = function()
  bundle_id = 'com.fvim.www'
  window = hs.window.get(hs.application.nameForBundleID(bundle_id))
  if (window == nil) then
    hs.application.open(bundle_id)
  else
    window:focus()
  end
  k.triggered = true
end
k:bind('', 'v', nil, vfun)

tfun = function()
  bundle_id = 'com.googlecode.iterm2'
  window = hs.window.get(hs.application.nameForBundleID(bundle_id))
  if (window == nil) then
    hs.application.open(bundle_id)
  else
    window:focus()
  end
  k.triggered = true
end
k:bind('', 't', nil, tfun)

rfun = function()
  hs.application.launchOrFocusByBundleID('com.tinyspeck.slackmacgap')
  k.triggered = true
end
k:bind('', 'r', nil, rfun)

ofun = function()
  hs.application.launchOrFocusByBundleID('com.apple.finder')
  k.triggered = true
end
k:bind('', 'o', nil, ofun)

pfun = function()
  hs.application.launchOrFocusByBundleID('net.sourceforge.skim-app.skim')
  k.triggered = true
end
k:bind('', 'p', nil, pfun)

sfun = function()
  hs.application.launchOrFocusByBundleID('com.todoist.mac.Todoist')
  k.triggered = true
end
k:bind('', 's', nil, sfun)

-- Hot keys for window management
hs.window.animationDuration = 0

-----------------------------------------------
-- hyper d for left one half window
-----------------------------------------------

k:bind('', 'd', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper g for right one half window
-----------------------------------------------

k:bind('', 'g', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper f for fullscreen
-----------------------------------------------

k:bind('', 'f', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Hyper l to resize window to 3/4 of screen
-----------------------------------------------

k:bind('', 'l', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 4)
        f.y = max.y
        f.w = 3 * max.w / 4
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Hyper j to resize to bottom 3/4 of screen
-----------------------------------------------

k:bind('', 'j', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y + (max.h / 2)
        f.w = max.w
        f.h = max.h * 0.52
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Hyper k to resize to top 3/4 of screen
-----------------------------------------------

k:bind('', 'k', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h * 0.52
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Hyper h to resize window to 1/4 of screen
-----------------------------------------------

k:bind('', 'h', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 4
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Hyper w to resize window to mid 1/2 of screen
-----------------------------------------------

k:bind('', 'w', nil, function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 4)
        f.y = max.y
        f.w = (max.w * 1) / 2
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Hotkeys for general moving
general_down = hs.hotkey.bind({'alt'}, 'j', nil, function()
	hs.eventtap.keyStroke({}, 'Down')
end)

general_up = hs.hotkey.bind({'alt'}, 'k', nil, function()
	hs.eventtap.keyStroke({}, 'Up')
end)

general_left = hs.hotkey.bind({'alt'}, 'h', nil, function()
	hs.eventtap.keyStroke({}, 'Left')
end)

general_right = hs.hotkey.bind({'alt'}, 'l', nil, function()
	hs.eventtap.keyStroke({}, 'Right')
end)

general_home = hs.hotkey.bind({'alt', 'shift'}, 'h', nil, function()
	hs.eventtap.keyStroke({'cmd'}, 'Left')
end)

general_end = hs.hotkey.bind({'alt', 'shift'}, 'l', nil, function()
	hs.eventtap.keyStroke({'cmd'}, 'Right')
end)

-- Switch tabs in Chrome
chrome_prev_tab = hs.hotkey.new({'cmd'}, 'j', nil, function() hs.eventtap.keyStroke({'ctrl'}, 'tab') end)
chrome_next_tab = hs.hotkey.new({'cmd'}, 'k', nil, function() hs.eventtap.keyStroke({'ctrl', 'shift'}, 'tab') end)
chrome_filter = hs.window.filter.new('Google Chrome')
    :subscribe(hs.window.filter.windowFocused,function()
       chrome_prev_tab:enable()
       chrome_next_tab:enable()
end)
    :subscribe(hs.window.filter.windowUnfocused,function()
       chrome_prev_tab:disable()
       chrome_next_tab:disable()
end)

-- Vim style modal bindings

-- Movements {{{2

-- h - move left {{{3
function left() hs.eventtap.keyStroke({}, "Left") end
normal:bind({}, 'h', left, nil, left)
-- }}}3

-- l - move right {{{3
function right() hs.eventtap.keyStroke({}, "Right") end
normal:bind({}, 'l', right, nil, right)
-- }}}3

-- k - move up {{{3
function up() hs.eventtap.keyStroke({}, "Up") end
normal:bind({}, 'k', up, nil, up)
-- }}}3

-- j - move down {{{3
function down() hs.eventtap.keyStroke({}, "Down") end
normal:bind({}, 'j', down, nil, down)
-- }}}3

-- w - move to next word {{{3
function word() hs.eventtap.keyStroke({"alt"}, "Right") end
normal:bind({}, 'w', word, nil, word)
normal:bind({}, 'e', word, nil, word)
-- }}}3

-- b - move to previous word {{{3
function back() hs.eventtap.keyStroke({"alt"}, "Left") end
normal:bind({}, 'b', back, nil, back)
-- }}}3

-- 0 - move to beginning of line {{{3
normal:bind({}, '0', function()
    hs.eventtap.keyStroke({"cmd"}, "Left")
end)
-- }}}3

-- $ - move to end of line {{{3
normal:bind({"shift"}, '4', function()
    hs.eventtap.keyStroke({"cmd"}, "Right")
end)

-- }}}3

-- g - move to beginning of text {{{3
normal:bind({}, 'g', function()
    hs.eventtap.keyStroke({}, "home")
end)
-- }}}3

-- G - move to end of text {{{3
normal:bind({"shift"}, 'g', function()
    hs.eventtap.keyStroke({}, "end")
end)
-- }}}3

-- <cmd-d> - page down {{{3
normal:bind({"cmd"}, "d", function()
    hs.eventtap.keyStroke({}, "pagedown")
end)
-- }}}3

-- <cmd-u> - page up {{{3
normal:bind({"cmd"}, "u", function()
    hs.eventtap.keyStroke({}, "pageup")
end)
-- }}}3

-- }}}2

-- Insert {{{2

-- i - insert at cursor {{{3
normal:bind({}, 'i', function()
    normal:exit()
    hs.alert.show('Insert mode')
end)
-- }}}3

-- I - insert at beggining of line {{{3
normal:bind({"shift"}, 'i', function()
    hs.eventtap.keyStroke({"cmd"}, "Left")
    normal:exit()
    hs.alert.show('Insert mode')
end)
-- }}}3

-- a - append after cursor {{{3
normal:bind({}, 'a', function()
    hs.eventtap.keyStroke({}, "Right")
    normal:exit()
    hs.alert.show('Insert mode')
end)
-- }}}3

-- A - append to end of line {{{3
normal:bind({"shift"}, 'a', function()
    hs.eventtap.keyStroke({"cmd"}, "Right")
    normal:exit()
    hs.alert.show('Insert mode')
end)
-- }}}3

-- o - open new line below cursor {{{3
normal:bind({}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Right")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.alert.show('Insert mode')
    end
end)
-- }}}3

-- O - open new line above cursor {{{3
normal:bind({"shift"}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd", "shift"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Left")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.eventtap.keyStroke({}, "Up")
        hs.alert.show('Insert mode')
    end
end)
-- }}}3

-- }}}2

-- Delete {{{2

-- d - delete character before the cursor {{{3
local function delete()
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, 'd', delete, nil, delete)
-- }}}3

-- x - delete character after the cursor {{{3
local function fndelete()
    hs.eventtap.keyStroke({}, "Right")
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, 'x', fndelete, nil, fndelete)
-- }}}3

-- D - delete until end of line {{{3
normal:bind({"shift"}, 'D', nil, function()
    normal:exit()
    hs.eventtap.keyStroke({"ctrl"}, "k")
    normal:enter()
end)
-- }}}3

-- / - search {{{2
normal:bind({}, '/', function() hs.eventtap.keyStroke({"cmd"}, "f") end)
-- }}}2

-- u - undo {{{2
normal:bind({}, 'u', function()
    hs.eventtap.keyStroke({"cmd"}, "z")
end)
-- }}}2

-- <c-r> - redo {{{2
normal:bind({"ctrl"}, 'r', function()
    hs.eventtap.keyStroke({"cmd", "shift"}, "z")
end)
-- }}}2

-- y - yank {{{2
normal:bind({}, 'y', function()
    hs.eventtap.keyStroke({"cmd"}, "c")
end)
-- }}}2

-- p - paste {{{2
normal:bind({}, 'p', function()
    hs.eventtap.keyStroke({"cmd"}, "v")
end)
-- }}}2

