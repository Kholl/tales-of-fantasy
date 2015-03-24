--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneScript = {
  -- Triggers
  isFloor = F(function(actor, scene) return scene.phys:isFloor(actor) end),
}
