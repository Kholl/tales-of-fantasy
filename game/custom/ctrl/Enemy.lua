--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Enemy = {  
  filter = function(actor, scene) return function(other)
    return not (actor == other)
  end
  end,
  
  eval = function(actor, scene) return function(other)
    return actor:eucl(other)
  end
  end,
  
  direction = function(this, actor)
    local dist = actor:distrel()
    return -Math.Sign(dist.x), -Math.Sign(dist.z)
  end,
}
