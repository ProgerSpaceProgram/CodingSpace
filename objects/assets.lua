local object = require("object")
local assets = object:extend("Assets")

--------------------------------------------------------------------------------

function assets:init()
  self.data = {font = {}, image = {}, shader = {}}

  self.font = self.data.font
  self.image = self.data.image
  self.shader = self.data.shader
end

function assets:load()
  for typename, type in pairs(self.data) do
    for name, asset in pairs(type) do
      if typename == "font" then
        self.data[typename][name] = love.graphics.newFont(unpack(asset))
      elseif typename == "image" then
        self.data[typename][name] = love.graphics.newImage(unpack(asset))
      elseif typename == "shader" then
        self.data[typename][name] = love.graphics.newShader(unpack(asset))
      end
    end
  end
end

function assets:registerImage(name, ...)
  self.data.image[name] = {...}
end

function assets:registerFont(name, ...)
  self.data.font[name] = {...}
end


function assets:registerShader(name, ...)
  self.data.image[name] = {...}
end


--------------------------------------------------------------------------------

return assets
