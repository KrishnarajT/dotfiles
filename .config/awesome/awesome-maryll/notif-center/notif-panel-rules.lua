local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local notif_panel = require('notif-center.notif-panel')

-- Create a wibox for each screen connected
screen.connect_signal("request::desktop_decoration", function(s)
  if s.index == 1 then
    -- Create the notif_panel
    s.notif_panel = notif_panel(s)
  end
end)

-- Hide panel when clients go fullscreen
showAgain = false
function updateRightBarsVisibility()
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
        if s.notif_panel then
          if fullscreen and s.notif_panel.visible then
            _G.screen.primary.notif_panel:toggle()
            showAgain = true
          elseif not fullscreen and not s.notif_panel.visible and showAgain then
            _G.screen.primary.notif_panel:toggle()
            showAgain = false
          end
        end

    end
  end
end


_G.tag.connect_signal(
  'property::selected',
  function(t)
    updateRightBarsVisibility()
  end
)

_G.client.connect_signal(
  'property::fullscreen',
  function(c)
    if c.first_tag then
      c.first_tag.fullscreenMode = c.fullscreen
    end
    updateRightBarsVisibility()
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if c.fullscreen then
      c.screen.selected_tag.fullscreenMode = false
      updateRightBarsVisibility()
    end
  end
)
