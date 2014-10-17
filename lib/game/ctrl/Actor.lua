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
  prof = nil,
  cmd = nil,
  
  create = function(this, init)
    State.create(this, init)
    this.data = ActorData.new(init)
    this.dirs = List().new()
    this.prof = init and init.prof or {}
    this.cmd = init and init.cmd or {}
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
    
    local actor = this    
    local state = actor.prof.state.atksp1
    
    local box = state.hit.box
    local pos, dim, dir = actor:pos(), actor:dim(), actor:dir()
    local off = scene:off()
    
    local hitbox = {
      x = pos.x + box.x*dir.x + off.x,
      y = pos.y + pos.z - dim.h + box.y + off.y,
      w = box.w * dir.x,
      h = box.h}

    love.graphics.rectangle("line", hitbox.x, hitbox.y, hitbox.w, hitbox.y)
    
    local box, off = actor:hitbox(), scene:off()
    box.x, box.y = box.x + off.x, box.y + off.y

    love.graphics.rectangle("line", box.x, box.y, box.w, box.y)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    this.dirs:each(function (i, dir)
      dir:update{actor = this, scene = scene, Math = Math}
    end)
  end,
  
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  box = function(this, val) return this.data:box(val) end,
  dim = function(this) return this:curr():dim() end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,  
  
  add = function(this, dir)
    this.dirs:add(dir)
    return this
  end,
  
  dist = function(this, actor)
    actor = actor or this:target()
    return Math.Dist(this:pos(), actor:pos())
  end,
  
  face = function(this, actor)
    actor = actor or this:target()
    this:dir().x = Math.Sign(actor:pos().x - this:pos().x)
    return this
  end,
    
  hitbox = function(this)
    local pos, box = this:pos(), this:box()
    return {x = pos.x - box.w*0.5, y = pos.y + pos.z - box.h, w = box.w, h = box.h}      
  end,
}
