--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/Anim")
require("game/custom/PMap")
require("game/custom/Asset")
require("game/custom/ctrl/Enemy")

return {
  dir = "ToF",
  view = {
    w = 320,
    h = 200,
    full = false,
    sync = true
  },
  scenes = {
    start = "game/stages/Palace.lua",
  },
}