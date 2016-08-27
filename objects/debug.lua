local keys = require("keys")

local object = require("object")
local debug = object:extend("Debug")

--------------------------------------------------------------------------------

function debug:init(assets)
  self.lines = {}
  self.visible = false

  self.assets = assets
  assets:registerFont("debug", "assets/fonts/RobotoMono-Regular.ttf", 14)

  local major, minor, revision, codename = love.getVersion()
  self.lines[1] =
    ("LÖVE %d.%d.%d - %s on %s with %s"):format(major, minor,
      revision, codename, love.system.getOS(), _VERSION)
end

function debug:draw()
  if self.visible then
    love.graphics.push()
      love.graphics.origin()
      love.graphics.setColor(236, 240, 241)
      love.graphics.setFont(self.assets.font.debug)
      for i = 1, #self.lines do
        if self.lines[i] then
          love.graphics.print(self.lines[i], 10, i * 18 - 8)
        end
      end
    love.graphics.pop()
  end
end

function debug:keyreleased(key)
  if key == keys.openDebug then
    self.visible = not self.visible
  end
end

function debug:update(dt)
  if self.visible then
    self.lines[3] = "FPS: " .. tostring(love.timer.getFPS())
    self.lines[4] = "Deltatime: " .. tostring(dt)
  end
end

--------------------------------------------------------------------------------

return debug
