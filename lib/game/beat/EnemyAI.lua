--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAI = function(init) return ActorRules.new{
  std = {
    Script.isRng("x", 0) / Script.act("bck"),
    Script.isRng("x", nil, init.rng) / Script.act("wlk"),
    Script.isRng("z", nil, init.rng) / Script.act("wlk"),
    Script.pick{
      Game.isHit("atk")  / Script.act("atk"),
      Game.isHit("atk1") / Script.act("atk1"),
      Game.isHit("atk2") / Script.act("atk2"),
      Game.isHit("atk3") / Script.act("atk3"),
      Game.isHit("atk4") / Script.act("atk4"),
      Game.isHit("atk5") / Script.act("atk5"),
      Game.isHit("atk6") / Script.act("atk6"),
    },
  },
  
  wlk = {
    Script.face,
    Script.isRng("x", init.rngjmp +20, init.rngjmp) /
      Script.act("jmp") /
      Script.move(init.spd, {x = 1, y = -1, z = 0}),
    Script.isRng("x", 0) / Script.act("bck"),
    Script.isRng("x", nil, init.rng) / Script.act("wlk"),
    Script.isRng("z", nil, init.rng) / Script.act("wlk"),
    Script.act("std"),
  },
  
  bck = {
    Script.face,
    Script.isRng("x", init.rng) / Script.act("bck"),
    Script.isRng("x", nil, init.rng) / Script.act("wlk"),
    Script.isRng("z", nil, init.rng) / Script.act("wlk"),
    Script.act("std"),
  },

  jmp = {
    Game.isHit("atkjmp") / Script.act("atkjmp"),
    Game.isHit("atkjmp1") / Script.act("atkjmp1"),
    Game.isHit("atkjmp2") / Script.act("atkjmp2"),
  },
} end
