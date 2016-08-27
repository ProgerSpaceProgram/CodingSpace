local class = require("utils.30log")
local vec2 = class("Vector2D")

function vec2:init(x, y)
  self.x = x or 0
  self.y = y or 0
end

--------------------------------------------------------------------------------

function vec2:__add(rhs)
  if type(rhs) == "number" then
    return vec2(self.x + rhs,   self.y + rhs)
  elseif class.isInstance(rhs, vec2) then
    return vec2(self.x + rhs.x, self.y + rhs.y)
  end
end

function vec2:__sub(rhs)
  if type(rhs) == "number" then
    return vec2(self.x - rhs,   self.y - rhs)
  elseif class.isInstance(rhs, vec2) then
    return vec2(self.x - rhs.x, self.y - rhs.y)
  end
end

function vec2:__mul(rhs)
  if type(rhs) == "number" then
    return vec2(self.x * rhs,   self.y * rhs)
  elseif class.isInstance(rhs, vec2) then
    return vec2(self.x * rhs.x, self.y * rhs.y)
  end
end

function vec2:__div(rhs)
  if type(rhs) == "number" then
    return vec2(self.x / rhs,   self.y / rhs)
  elseif class.isInstance(rhs, vec2) then
    return vec2(self.x / rhs.x, self.y / rhs.y)
  end
end

function vec2:__pow(rhs)
  if type(rhs) == "number" then
    return vec2(self.x ^ rhs,   self.y ^ rhs)
  elseif class.isInstance(rhs, vec2) then
    return vec2(self.x ^ rhs.x, self.y ^ rhs.y)
  end
end

function vec2:__eq(rhs)
  if type(rhs) == "number" then
    return self.x == rhs   and self.y == rhs
  elseif class.isInstance(rhs, vec2) then
    return self.x == rhs.x and self.y == rhs.y
  end

  return false
end

function vec2:__lt(rhs)
  if type(rhs) == "number" then
    return self.x < rhs    and self.y < rhs
  elseif class.isInstance(rhs, vec2) then
    return self.x < rhs.x or self.x == rhs.x and self.y < rhs.y
  end

  return false
end

function vec2:__tostring()
  return "vec2 [" .. tostring(self.x) .. " " .. tostring(self.y) .. "]"
end

--------------------------------------------------------------------------------

function vec2:xy()
  return self.x, self.y
end

function vec2:clone()
  return vec2(self.x, self.y)
end

function vec2:len()
  return math.sqrt(self.x * self.x + self.y * self.y)
end

function vec2:len2()
  return self.x * self.x + self.y * self.y
end

vec2.__len = vec2.len

function vec2:dist(rhs)
  if not class.isInstance(rhs, vec2) then
    error("bad argument #1 to 'dist' (vec2 excepted, got nil)")
  end

  return (self - rhs):len()
end

function vec2:dist2(rhs)
  if not class.isInstance(rhs, vec2) then
    error("bad argument #1 to 'dist2' (vec2 excepted, got nil)")
  end

  return (self - rhs):len2()
end

function vec2:normalizeMut()
	local len = self:len()

	if len > 0 then
		self.x, self.y = self.x / len, self.y / len
	end

	return self
end

function vec2:normalize()
  return self:clone():normalizeMut()
end

function vec2:rotateMut(phi)
	local cos, sin = math.cos(phi), math.sin(phi)
	self.x, self.y = cos * self.x - sin * self.y, sin * self.x + cos * self.y
	return self
end

function vec2:rotate(phi)
	return self:clone():rotateMut()
end

function vec2:perpendicular()
  return vec2(-self.y, self.x)
end

function vec2:project(rhs)
  if not class.isInstance(rhs, vec2) then
    error("bad argument #1 to 'dist2' (vec2 excepted, got nil)")
  end

  return (self * rhs) * rhs / rhs:len2()
end

function vec2:mirror(rhs)
  if not class.isInstance(rhs, vec2) then
    error("bad argument #1 to 'dist2' (vec2 excepted, got nil)")
  end

  return 2 * self:projectOn(rhs) - self
end

function vec2:cross(rhs)
  if not class.isInstance(rhs, vec2) then
    error("bad argument #1 to 'dist2' (vec2 excepted, got nil)")
  end

  return self.x * rhs.y + self.y * self.x
end

--------------------------------------------------------------------------------

return vec2
