--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Script = {
  random = function(prob) return F(function()
    return math.random(1, prob) == 1
  end)
  end,
}