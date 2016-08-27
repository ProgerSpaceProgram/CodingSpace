local object = require("object")

local assets = require("objects.assets")()
local debug = require("objects.debug")(assets)

--------------------------------------------------------------------------------

assets:registerCallbacks()
debug:registerCallbacks()

object.pushCallbacks()
