--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  all = {
    Game.Rule.Auto.notarget,
    Game.Rule.Auto.target{
      std = {wlk = true, jmp = true, atk = true, atkalt = true},
      wlk = {wlk = true, jmp = true},
      jmp = {atkjmp = true},
    },
  },
  std = {
    Game.Rule.action("wlk"),
    Game.Rule.action("jmp"),
    Game.Rule.action("atk"),
    Game.Rule.action("atkalt"),
  },
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
    Game.Rule.action("atkjmp"),
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
  hithvy = {
    Game.Rule.fall("hitair"),
  },
  atkjmp = {
    Game.Rule.attack,
    Game.Rule.finish("jmp"),
    Game.Rule.floor("std"),
  },
  atkalt = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
}