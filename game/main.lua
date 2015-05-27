--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/FX")
require("game/custom/Anim")
require("game/custom/Asset")
require("game/custom/ctrl/dlg/EnemyDlg")

require("lib/game/ctrl/Frame")

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
    start = "game/stages/Palace.lua",
  },
  interface = {
    items = {}
  },
}