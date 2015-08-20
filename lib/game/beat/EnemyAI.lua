--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAI = function(init) return ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, init.rng) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
--    ActorScript.isTargetHit{"atk", "atk1", "atk2", "atk3"} .. ActorScript.act,

    ActorScript.pick{
      ActorScript.isTargetHit{"atk"} / ActorScript.act("atk"),
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
      ActorScript.isTargetHit{"atk4"} / ActorScript.act("atk4"),
      ActorScript.isTargetHit{"atk5"} / ActorScript.act("atk5"),
      ActorScript.isTargetHit{"atk6"} / ActorScript.act("atk6"),
      ActorScript.isTargetHit{"atk7"} / ActorScript.act("atk7"),
      ActorScript.isTargetHit{"atk8"} / ActorScript.act("atk8"),
      ActorScript.isTargetHit{"atk9"} / ActorScript.act("atk9"),
    },
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", init.rngjmp +20, init.rngjmp) /
       ActorScript.act("jmp") /
       ActorScript.move(init.spd, {x = 1, y = -1, z = 0}),
     ActorScript.isRange("x", init.rng) / ActorScript.act("std"),
     ActorScript.isRange("x", init.rng -10) / ActorScript.act("bck"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, init.rng -10) / ActorScript.act("std"),
  },
    
  jmp = {
    ActorScript.isTargetHit{"atkjmp"} / ActorScript.act("atkjmp"),
    ActorScript.isTargetHit{"atkjmp1"} / ActorScript.act("atkjmp1"),
    ActorScript.isTargetHit{"atkjmp2"} / ActorScript.act("atkjmp2"),
  },

} end
