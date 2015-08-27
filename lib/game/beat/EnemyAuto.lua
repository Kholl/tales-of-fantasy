--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.EnemyAuto = function(init) return ActorRules.new{
  wlk = {  Script.move(init.spd, {x = 1, y = 0, z = 1}) },
  bck = {  Script.move(init.spd, {x = -0.6, y = 0, z = 0}) },
  jmp = {  Script.isFloor / Script.act("std") },
  hit = { -Script.isFloor / Script.act("hitair"),
           Script.isEnded / Script.act("std") },
  hitair = {  Script.isFloor / Script.act("hitflr") },
  hithvy = { -Script.isFloor / Script.act("hitair"),
              Script.isEnded / Script.act("std") },
  hitflr = {  Script.isEnded / Script.act("std") },
  jmpend = {  Script.isFloor / Script.act("std") },
}
end