--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAI = function(init) return ActorRules.new{
  std = {
    Script.isRng("x", nil, init.rng) / Script.act("wlk"),
    Script.isRng("x", 0) / Script.act("bck"),
    Script.pick{
      Beat.Script.isHit("atk") / Script.act("atk"),
      Beat.Script.isHit("atk1") / Script.act("atk1"),
      Beat.Script.isHit("atk2") / Script.act("atk2"),
      Beat.Script.isHit("atk3") / Script.act("atk3"),
      Beat.Script.isHit("atk4") / Script.act("atk4"),
      Beat.Script.isHit("atk5") / Script.act("atk5"),
      Beat.Script.isHit("atk6") / Script.act("atk6"),
    },
  },
  
  wlk = {
     Script.face,
     Script.isRng("x", init.rngjmp +20, init.rngjmp) /
       Script.act("jmp") /
       Script.move(init.spd, {x = 1, y = -1, z = 0}),
     Script.isRng("x", init.rng) / Script.act("std"),
     Script.isRng("x", init.rng -10) / Script.act("bck"),
  },
  
  bck = {
    Script.face,
    Script.isRng("x", nil, init.rng -10) / Script.act("std"),
  },
    
  jmp = {
    Beat.Script.isHit("atkjmp") / Script.act("atkjmp"),
    Beat.Script.isHit("atkjmp1") / Script.act("atkjmp1"),
    Beat.Script.isHit("atkjmp2") / Script.act("atkjmp2"),
  },
} end
