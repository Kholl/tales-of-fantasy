--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/Anim")
require("game/custom/PMap")
require("game/custom/Asset")
require("game/custom/ctrl/dlg/EnemyDlg")

return {
  dir = "ToF",
  fps = 30,
  view = {
    w = 320,
    h = 240,
    full = false,
    sync = true
  },
  scenes = {
    palace = "game/stages/Palace.lua",
  },
}