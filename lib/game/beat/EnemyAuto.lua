--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAuto = function(init) return ActorDlg.new{
  wlk = {  ActorScript.move(init.spd, {x = 1, y = 0, z = 1}) },
  bck = {  ActorScript.move(init.spd, {x = -0.6, y = 0, z = 0}) },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("std") },
} end