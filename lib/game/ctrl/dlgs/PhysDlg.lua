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
  
  update = function(this, actor, scene)
    local spd = actor:spd()
    local pos = actor:pos()
    
    local k = {x = 0, y = 0, z = 0}
    if pos[this.grav] == 0 then
      k.x = Math.Sign(spd.x)
      k.y = Math.Sign(spd.y)
      k.z = Math.Sign(spd.z)
    end
    k[this.grav] = 1    
    
    pos.x = pos.x + (spd.x * scene.delta)
    pos.y = pos.y + (spd.y * scene.delta)
    pos.z = pos.z + (spd.z * scene.delta)
    
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
        
        pos.x = Math.Linear(actor:pos().x, other:pos().x + angle.x * dist, ratio)
        pos.z = Math.Linear(actor:pos().z, other:pos().z + angle.z * dist, ratio)
      end)
    end

    spd.x = spd.x + (k.x * this.drag.x * scene.delta)
    spd.y = spd.y + (k.y * this.drag.y * scene.delta)
    spd.z = spd.z + (k.z * this.drag.z * scene.delta)
    
    local lim = scene:lim()
    pos.x = Math.Lim(pos.x, lim.x)
    pos.y = Math.Lim(pos.y, lim.y)
    pos.z = Math.Lim(pos.z, lim.z)
    
    actor:floor(pos[this.grav] == 0)    
    if actor:floor() then spd[this.grav] = 0 end
  end,
}
