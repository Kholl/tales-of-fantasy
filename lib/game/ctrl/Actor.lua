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
    
    local pos = this:pos()
    local dim = this:dim()
    local box = this:box()
    local face = this:face()
    local hit = this.prof.hit.box
    local off = scene:off()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line",
      pos.x + off.x - dim.w*0.5,
      pos.y + pos.z + off.y,
      dim.w, -dim.h)
    
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("line",
      pos.x + off.x - box.w*0.5,
      pos.y + pos.z + off.y - box.h,
      box.w, box.h)
    
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("line",
      pos.x + off.x + (hit.x * face),
      pos.y + pos.z + off.y - dim.h + hit.y,
      hit.w * face, hit.h)
    
    love.graphics.setColor(255, 255, 255)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    this.dirs:each(function (i, dir)
      dir:update{actor = this, scene = scene, Math = Math}
    end)
  end,
  
  sca = function(this, val) return this.data:sca(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  box = function(this, val) return this.data:box(val) end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,
  
  dim = function(this) return this:curr():dim() end,
  
  face = function(this) return Math.Sign(this:sca().x) end,
  dist = function(this, actor) return Math.Dist(this:pos(), (actor or this:target()):pos()) end,
    
  add = function(this, dir) this.dirs:add(dir) end,    
}
