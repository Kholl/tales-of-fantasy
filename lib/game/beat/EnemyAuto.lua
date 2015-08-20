--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

EnemyAuto = function(init) return ActorDlg.new{
  wlk = {  ActorScript.move{x = init.spd, z = init.spd} },
  bck = {  ActorScript.move{x = -init.spd/2} },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("std") },
} end