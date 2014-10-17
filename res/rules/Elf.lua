--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

atksp1 = {
  chk = function() return actor:floor() and actor.cmd.b1 and actor.cmd.d end,
  cmd = function() actor:start("atksp1") end,
}

atksp1end = {
  chk = function() return actor:curr():isEnded() end,
  cmd = function() actor:start("std") end,
}

return {
  std = {atksp1},
  atksp1 = {atksp1end},
}