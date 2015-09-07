--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--


require("game/custom/Game")
Import(Game)
Import(Beat)
Import(Script)

return {
  x = 0, y = 0,
  w = 320, h = 240,
  full = false,
  sync = true,
  dir = "ToF",
  fps = 30,
  input = {
    [1] = {
      controller = "keyboard",
      keys = {
        r = "right",
        l = "left",
        u = "up",
        d = "down",
        a = "a",
        b = "s",
      },
    },
    [2] = {
      controller = "gamepad",
      keys = {
        r = "right",
        l = "left",
        u = "up",
        d = "down",
        a = 1,
        b = 2,
      },
    },
  },
--  start = "game/stages/Palace.1.lua",
  start = "game/stages/Palace.2.lua",
--  start = "game/stages/Tester.lua",
  interface = {
    items = {}
  },
}