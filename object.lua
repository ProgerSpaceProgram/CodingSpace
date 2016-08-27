local class = require("utils.30log")
local object = class("Object")

local loveCallbacks = {
  directorydropped = {},
  draw = {},
  errhand = {},
  filedropped = {},
  focus = {},
  keypressed = {},
  keyreleased = {},
  load = {},
  lowmemory = {},
  mousefocus = {},
  mousemoved = {},
  mousepressed = {},
  mousereleased = {},
  quit = {},
  resize = {},
  run = {},
  textedited = {},
  textinput = {},
  threaderror = {},
  touchmoved = {},
  touchpressed = {},
  touchreleased = {},
  update = {},
  visible = {},
  wheelmoved = {},
}

--------------------------------------------------------------------------------

function object:registerCallbacks()
  for name, callbacks in pairs(loveCallbacks) do
    if type(self[name]) == "function" then
      table.insert(callbacks, {fn = self[name], self = self})
    end
  end
end

function object.pushCallbacks()
  for name, callbacks in pairs(loveCallbacks) do
    if #callbacks > 0 then
      local old = love[name]
      love[name] = function (...)
        if old then
          old(...)
        end

        for i, callback in ipairs(callbacks) do
          if callback.fn(callback.self, ...) == false then
            return
          end
        end
      end
    end
  end
end

--------------------------------------------------------------------------------

return object
