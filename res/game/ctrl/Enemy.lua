--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Enemy = Moo.Class {
  create = function(this, init)
  end,
  
  update = function(this, actor, scene)
    if not actor:target() then return this:findTarget(actor, scene) end
  end,
  
  findTarget = function(this, actor, scene)
    local filter = function(other) return actor:isTarget(other) end
    local sorter = function(a, b) return actor:priority(a) < actor:priority(b) end
    local target = scene:getActors():filter(filter):sort(sorter):first()
    actor:target(target)
  end,
}
