--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAuto = function(init) return ActorRules.new{
  wlk = {  Script.move(init.spd, {x = 1, y = 0, z = 1}) },
  bck = {  Script.move(init.spd, {x = -0.6, y = 0, z = 1}) },
  jmp = {  Script.isFloor / Script.act("std") },
  hit = { -Script.isFloor / Script.act("hitair"),
           Script.isEnded / Script.act("std"),
           Script.extra("hp").leq(0) / Script.move{x = -100, y = -150} / Script.act("hitair") },
  hitair = {  Script.isFloor ^ Script.extra("hp").leq(0) / Script.act("die"),
              Script.isFloor / Script.act("hitflr") },
  hithvy = { -Script.isFloor / Script.act("hitair"),
              Script.isEnded / Script.act("std") },
  hitflr = {  Script.isEnded / Script.act("std") },
  jmpend = {  Script.isFloor / Script.act("std") },
}
end