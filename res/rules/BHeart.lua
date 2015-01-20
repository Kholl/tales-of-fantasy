--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  all = {
    Game.Rule.Auto.notarget,
    Game.Rule.Auto.target{
      std = {wlk = true, atk = true, atkalt = true},
      wlk = {wlk = true},
    },
  },
  std = {
    Game.Rule.action("wlk"),
    Game.Rule.action("atk"),
    Game.Rule.action("atkalt"),
  },
  wlk = {
    Game.Rule.action("wlk"),
    Game.Rule.idle("std"),
  },
  atk = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
  hit = {
    Game.Rule.nofloor("hitair"),
    Game.Rule.finish("std"),
  },
  hitair = {
    Game.Rule.floor("hitflr"),
  },
  hitflr = {
    Game.Rule.nodie("std"),
  },
  atkalt = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
}