--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

EnemyDlg = Moo.Class {
  ruleset = "autorules",
  
  step = Nil,
  update = Nil,
  
  filter = function(this, actor, scene) return function(other)
    return not (actor == other)
  end
  end,
  
  eval = function(this, actor, scene) return function(other)
    return actor:eucl(other)
  end
  end,
  
  direction = function(this, actor)
    local dhit = actor:disthit()
    local dist = actor:distrel()
    local x, z = dist.x, dist.z
    if dhit.x < 0 then x = 0 end
    if dhit.z < 0 then z = 0 end
   
    return -Math.Sign(x), -Math.Sign(z)
  end,
}
