--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/scene/Scene")

Script = {
  always = F{function() return true end},
  never = F{function() return false end},
  
  random = function(prob) return F{function()
    return math.random(1, prob) == 1
  end}
  end,

  pick = function(list) return F{function()
    local keys, vals = List.divide(list)
    local key = keys[math.random(1, #keys)]
    return list[key]
  end}
  end,

  loadScene = function(game, name)
    game.scene = Scene.new(name)
    game.ui:time(0)
    
    game.scene:step(game)
    game.scene:update(0, nil, game)
    
    game.ui:step(game)
    game.ui:update(0, nil, game)
  end,
}