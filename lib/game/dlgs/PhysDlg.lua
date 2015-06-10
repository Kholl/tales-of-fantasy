--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

PhysDlg = Class {
  drag = nil,
  grav = nil,
  
  create = function(this, init)
    this.drag = (init and init.drag) or 0
    this.grav = (init and init.grav) or 0
  end,
  
  step = Nil,
  
  update = function(this, delta, actor, scene, game)
    local spd = actor:spd()
    local pos = actor:pos()
    
    local k = {x = 0, y = 0, z = 0}
    if pos[this.grav] == 0 then
      k.x = Math.Sign(spd.x)
      k.y = Math.Sign(spd.y)
      k.z = Math.Sign(spd.z)
    end
    k[this.grav] = 1    
    
    pos.x = pos.x + (spd.x * delta)
    pos.y = pos.y + (spd.y * delta)
    pos.z = pos.z + (spd.z * delta)
    
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

    spd.x = spd.x + (k.x * this.drag.x * delta)
    spd.y = spd.y + (k.y * this.drag.y * delta)
    spd.z = spd.z + (k.z * this.drag.z * delta)
    
    local lim = scene:lim()
    pos.x = Math.Lim(pos.x, lim.x)
    pos.y = Math.Lim(pos.y, lim.y)
    pos.z = Math.Lim(pos.z, lim.z)
    
    actor:spd(spd)
    actor:pos(pos)
    if this:isFloor(actor) then spd[this.grav] = 0 end
  end,
  
  isFloor = function(this, actor) return actor:pos()[this.grav] == 0 end,
}
