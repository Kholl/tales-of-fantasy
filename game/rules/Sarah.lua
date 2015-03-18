--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  all = {
    Game.Rule.Auto.notarget,
    Game.Rule.Auto.target{
      std = {"wlk", "jmp", "run", "blk", "atk", "atkalt", "atkup", "atkrnd"},
      atk = {"atksq1"},
      atksq1 = {"atksq2"},
      atksq2 = {"atksq3"},
      wlk = {"wlk", "jmp", "run"},
      run = {"run", "jmp", "atkrun"},
      runend = {"dodge"},
      jmp = {"atkjmp"},
      blk = {"blk"},
    },
  },
  std = {
    Game.Rule.action("wlk"),
    Game.Rule.action("jmp"),
    Game.Rule.action("run"),
    Game.Rule.action("blk"),
    Game.Rule.action("atk"),
    Game.Rule.action("atkalt"),
    Game.Rule.action("atkup"),
    Game.Rule.action("atkrnd")},
  wlk = {
    Game.Rule.action("run"),
    Game.Rule.action("wlk"),
    Game.Rule.action("jmp"),
    Game.Rule.idle("std"),
  },
  run = {
    Game.Rule.action("run"),
    Game.Rule.action("jmp"),
    Game.Rule.action("atkrun"),
    Game.Rule.action("dodge"),
    Game.Rule.idle("runend"),
  },
  runend = {
    Game.Rule.finish("std"),
  },
  blk = {
    Game.Rule.action("blk"),
    Game.Rule.idle("std"),
  },
  dodge = {
    Game.Rule.finish("std"),
  },
  atk = {
    Game.Rule.attack,
    Game.Rule.chain("atksq1"),
    Game.Rule.finish("std"),
  },
  atksq1 = {
    Game.Rule.attack,
    Game.Rule.chain("atksq2"),
    Game.Rule.finish("std"),
  },
  atksq2 = {
    Game.Rule.attack,
    Game.Rule.chain("atksq3"),
    Game.Rule.finish("std"),
  },
  atksq3 = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
  jmp = {
    Game.Rule.action("atkjmp"),
    Game.Rule.floor("std"),
  },
  jmprun = {
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
  hitalt = {
    Game.Rule.nofloor("hitair"),
    Game.Rule.finish("std"),
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
  atkrun = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
  atkup = {
    Game.Rule.attack,
    Game.Rule.finish("jmp"),
  },
  atkrnd = {
    Game.Rule.attack,
    Game.Rule.finish("std"),
  },
}