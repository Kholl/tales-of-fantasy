--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  player = function(scene, name)
    return function(keyset)
      local actor = scene.actors:addNew(string.format("res/chars/%s.lua", name))
      actor:keyb(keyset)
      return actor
    end
  end,
  
  spawn = function(scene, name)
    local actor = scene.actors:addNew(string.format("res/chars/%s.lua", name))
    actor:setRule(string.format("res/rules/%s.lua", name))
    actor.info.auto = true
    return actor
  end,
}