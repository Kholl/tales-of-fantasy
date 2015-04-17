--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

EnemyDlg = Moo.Class {
  dir = nil,
  refresh = nil,
  
  create = function(this, init)
    this.dir = {x = 0, z = 0}
    this.refresh = init and init.refresh or 30
  end,
  
  step = function(this, actor, scene)
    if math.floor(scene:frame()) % this.refresh == 0 then
      this.dir = false
    end
  end,
  
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
    if not this.dir then
      local dist = actor:distrel()
      local dim = actor:target():dim()
      local kx, kz = Math.Sign(dim.w - math.abs(dist.x)), -1
      
      this.dir = {
        x = kx * Math.Sign(dist.x),
        z = kz * Math.Sign(dist.z),
      }
    end
    
    return this.dir.x, this.dir.z
  end,
}
