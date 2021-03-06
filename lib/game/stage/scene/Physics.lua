--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Physics = Class {
  drag = nil,
  grav = nil,
  
  create = function(this, init)
    this.drag = XYZ(init and init.drag or {x = 0, y = 0, z = 0})
    this.grav = init and init.grav or 0
  end,
  
  step = Nil,
  
  update = function(this, delta, actor, scene, game)
    local spd = actor:spd()
    local pos = actor:pos()
    
    local k = {x = 0, y = 0, z = 0}
    if pos[this.grav] == 0 then k = Math.Sign(spd) end
    k[this.grav] = 1    
    
    pos = pos + (spd * delta)
    
    if actor:rad() > 0 then
      local actors = scene:getActors(function(other)
        return not (actor == other)
          and other:rad() > 0
          and actor:eucl(other) < (actor:rad() + other:rad())
      end)
    
      List.each(actors, function(other)
        local ratio = Math.Ratio(actor:mass(), other:mass())      
        local angle = actor:angle(other)
        local dist = actor:rad() + other:rad()
        
        pos.x = Math.Linear(pos.x, other:pos().x + angle.x * dist, ratio)
        pos.z = Math.Linear(pos.z, other:pos().z + angle.z * dist, ratio)
      end)
    end
    
    pos = Math.Lim(pos, scene:lim())
    spd = spd + (k * this.drag * delta)
    
    if pos[this.grav] > 0 then pos[this.grav], spd[this.grav] = 0, 0 end
    
    actor:spd(spd)
    actor:pos(pos)
  end,
  
  isFloor = function(this, actor) return actor:pos()[this.grav] >= 0 end,
}
