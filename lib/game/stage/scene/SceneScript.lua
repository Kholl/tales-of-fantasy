--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneScript = {
  -- Triggers
  at = function(time) return F{function(scene, game)
    return scene:time() >= time
  end}
  end,
}
