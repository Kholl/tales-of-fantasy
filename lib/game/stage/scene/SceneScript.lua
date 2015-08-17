--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneScript = {
  -- Triggers
  at = function(start, finish) return F{function(scene, game)
    finish = finish or start + (1 / game.fps)
    return scene:time() >= start and scene:time() < finish
  end}
  end,

  -- Actions
  act = function(action) return F{function(scene, game)
    scene:state(action)
  end}
  end,
  
  dialog = function(id) return F{function(scene, game)
    game.ui:add(Dialog.new("game/preset/dialog/Dialog.lua", Load("game/stages/dialog/".. id)))
  end}
  end,

  focus = function(target) return F{function(scene, game)
    scene:get("camera"):focus(target)
  end}
  end,
  
  spawn = function(key, init, custom) return F{function(scene, game)
    scene:addActor(key, init, custom)
  end}
  end,
  
  all = function(list) return F{function(scene, game)
    List.each(list, function(rule) rule(scene, game) end)
    return false
  end}
  end,

  loadScene = function(name) return F{function(scene, game)
    game.scene = Scene.new(name)
    game.ui:time(0)
    
    game.scene:step(game)
    game.scene:update(0, nil, game)
    
    game.ui:step(game)
    game.ui:update(0, nil, game)
  end}
  end,
}
