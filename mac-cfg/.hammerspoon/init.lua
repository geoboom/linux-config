-- DISPLAY FOCUS SWITCHING --

--One hotkey should just suffice for dual-display setups as it will naturally
--cycle through both.
--A second hotkey to reverse the direction of the focus-shift would be handy
--for setups with 3 or more displays.

left_screen = hs.screen.primaryScreen()
right_screen = left_screen:next()

--Bring focus to next / prev screen
hs.hotkey.bind({"alt", "cmd"}, "`", function ()
    focusNextScreen()
end)
hs.hotkey.bind({"alt", "cmd", "shift"}, "`", function ()
    focusPrevScreen()
end)

function focusNextScreen()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    focusScreen(screen:next())
end

function focusPrevScreen()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    focusScreen(screen:previous())
end

--Bring focus to left screen
hs.hotkey.bind({"alt", "cmd"}, "h", function ()
  focusScreen(left_screen)
  focusScreen(left_screen)
end)
hs.hotkey.bind({"alt", "cmd"}, "j", function ()
  focusScreen(left_screen)
  focusScreen(left_screen)
end)

--Bring focus to right screen
hs.hotkey.bind({"alt", "cmd"}, "k", function ()
  focusScreen(right_screen)
  focusScreen(right_screen)
end)
hs.hotkey.bind({"alt", "cmd"}, "l", function ()
  focusScreen(right_screen)
  focusScreen(right_screen)
end)

--Bring window to left screen
hs.hotkey.bind({"alt", "cmd", "shift"}, "h", function ()
  moveWindowToScreen(left_screen)
end)
hs.hotkey.bind({"alt", "cmd", "shift"}, "j", function ()
  moveWindowToScreen(left_screen)
end)

--Bring window to right screen
hs.hotkey.bind({"alt", "cmd", "shift"}, "k", function ()
  moveWindowToScreen(right_screen)
end)
hs.hotkey.bind({"alt", "cmd", "shift"}, "l", function ()
  moveWindowToScreen(right_screen)
end)




--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

-- Brings focus to the scren by setting focus on the front-most application in it.
-- Also move the mouse cursor to the center of the screen. This is because
-- Mission Control gestures & keyboard shortcuts are anchored, oddly, on where the
-- mouse is focused.
function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(
      hs.window.orderedWindows(),
      hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
  local pt = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.absolutePosition(pt)
end

function moveWindowToScreen(dstScreen)
    local focusedWin = hs.window.focusedWindow()
    if not (focusedWin == hs.window.desktop()) then
        focusedWin:moveToScreen(dstScreen, true, true, 0)
    end
    focusScreen(dstScreen)
end

-- TODO: when move fullscreen window across monitors, maintain fullscreen

-- END DISPLAY FOCUS SWITCHING --

