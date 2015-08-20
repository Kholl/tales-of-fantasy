--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

EnemyAI = function(init) return ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, init.rng) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", init.rngjmp +20, init.rngjmp) /
       ActorScript.act("jmp") /
       ActorScript.move{x = init.spd, y = -init.spd*2, z = 0},
     ActorScript.isRange("x", init.rng) / ActorScript.act("std"),
     ActorScript.isRange("x", init.rng -10) / ActorScript.act("bck"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, init.rng +20) / ActorScript.act("std"),
  },
} end
