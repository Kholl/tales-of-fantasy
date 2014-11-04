--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/data/ActorData")

Actor = Class {
  super = State,
  
  data = nil,
  dirs = nil,
  info = nil,
  
  create = function(this, init)
    State.create(this, init)
    this.data = ActorData.new(init)
    this.dirs = List().new()
    this.info = init and init.info or {}
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    this.dirs:each(function (i, dir)
      dir:update{actor = this, scene = scene, Math = Math, Each = Each, print = print}
    end)
  
    this:action(false)
  end,
  
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  box = function(this, val) return this.data:box(val) end,
  dim = function(this) return this:curr():dim() end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,  
  action = function(this, val) return this.data:action(val) end,
  
  add = function(this, dir) this.dirs:add(dir) end,
  
  dist = function(this, actor)
    actor = actor or this:target()
    return Math.Dist(this:pos(), actor:pos())
  end,
  
  eucl = function(this, ratio)
    ratio = ratio or {x = 1, y = 1, z = 1}
    return function(actor)
      local d = this:dist(actor)
      return math.sqrt(d.x*d.x*ratio.x + d.y*d.y*ratio.y + d.z*d.z*ratio.z)
    end
  end,
  
  face = function(this, actor)
    actor = actor or this:target()
    this:dir().x = Math.Sign(actor:pos().x - this:pos().x)
    return this
  end,
  
  facing = function(this, actor)
    actor = actor or this:target()
    return (this:dir().x * actor:dir().x) == -1
  end,
    
  hitbox = function(this)
    local pos, box = this:pos(), this:box()
    return {x = pos.x - box.w*0.5, y = pos.y + pos.z - box.h, w = box.w, h = box.h}      
  end,
}
