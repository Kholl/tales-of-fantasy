--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/Game")

return {
  x = 0, y = 0,
  w = 320, h = 240,
  full = false,
  sync = true,
  dir = "ToF",
  fps = 30,
  keyb = {
    {
      r = "right",
      l = "left",
      u = "up",
      d = "down",
      a = "a",
      b = "s",
    },
  },
--  start = "game/stages/Palace.1.lua",
  start = "game/stages/Palace.2.lua",
  interface = {
    items = {}
  },
}