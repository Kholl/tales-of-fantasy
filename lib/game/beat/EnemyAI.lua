--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAI = function(init) return ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, init.rng) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      Beat.Script.isTargetHit("atk") / ActorScript.act("atk"),
      Beat.Script.isTargetHit("atk1") / ActorScript.act("atk1"),
      Beat.Script.isTargetHit("atk2") / ActorScript.act("atk2"),
      Beat.Script.isTargetHit("atk3") / ActorScript.act("atk3"),
      Beat.Script.isTargetHit("atk4") / ActorScript.act("atk4"),
      Beat.Script.isTargetHit("atk5") / ActorScript.act("atk5"),
      Beat.Script.isTargetHit("atk6") / ActorScript.act("atk6"),
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
    Beat.Script.isTargetHit("atkjmp") / ActorScript.act("atkjmp"),
    Beat.Script.isTargetHit("atkjmp1") / ActorScript.act("atkjmp1"),
    Beat.Script.isTargetHit("atkjmp2") / ActorScript.act("atkjmp2"),
  },
} end
