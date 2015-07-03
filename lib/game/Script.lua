--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/scene/Scene")

Script = {
  always = F(function() return true end),
  never = F(function() return false end),
  
  random = function(prob) return F(function()
    return math.random(1, prob) == 1
  end)
  end,

  loadScene = function(game, name)
    game.scene = Scene.new(name)
    game.ui:time(0)
    
    game.scene:update(0, nil, game)
    game.ui:update(0, nil, game)
  end,
}