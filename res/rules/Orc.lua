--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  all = {
    Game.Rule.Auto.notarget,
    Game.Rule.Auto.target{
      std = {"wlk", "jmp", "atk"},
      wlk = {"wlk", "jmp"},
    },
  },
  std = {
    Game.Rule.action("wlk"),
    Game.Rule.action("jmp"),
    Game.Rule.action("atk"),
  wlk = {
    Game.Rule.action("wlk"),
    Game.Rule.action("jmp"),
    Game.Rule.idle("std"),
  },
  atk = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
  jmp = {
    Game.Rule.floor("std"),
  },
  hit = {
    Game.Rule.nofloor("hitair"),
    Game.Rule.finish("std"),
  },
  hitair = {
    Game.Rule.floor("hitflr"),
  },
  hitflr = {
    Game.Rule.finish("std"),
    Game.Rule.died("die"),
  },
}