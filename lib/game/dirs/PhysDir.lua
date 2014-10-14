--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

PhysDir = Class {
  drag = nil,
  grav = nil,
  
  create = function(this, init)
    this.drag = (init and init.drag) or 0
    this.grav = (init and init.grav) or 0
  end,
  
  update = function(this, context)
    local actor = context.actor
    local scene = context.scene
    
    local spd = actor:spd()
    local pos = actor:pos()
    
    local k = {x = 0, y = 0, z = 0}
    if pos[this.grav] == 0 then
      k.x = Math.Sign(spd.x)
      k.y = Math.Sign(spd.y)
      k.z = Math.Sign(spd.z)
    end
    k[this.grav] = 1
    
    local lim = scene:lim()
    
    pos.x = pos.x + (spd.x * scene.delta)
    pos.y = pos.y + (spd.y * scene.delta)
    pos.z = pos.z + (spd.z * scene.delta)
    
    pos.x = Math.Lim(pos.x, lim.x)
    pos.y = Math.Lim(pos.y, lim.y)
    pos.z = Math.Lim(pos.z, lim.z)

    spd.x = spd.x + (k.x * this.drag.x * scene.delta)
    spd.y = spd.y + (k.y * this.drag.y * scene.delta)
    spd.z = spd.z + (k.z * this.drag.z * scene.delta)
    
    actor:floor(pos[this.grav] == 0)    
    if actor:floor() then spd[this.grav] = 0 end
  end,
}
