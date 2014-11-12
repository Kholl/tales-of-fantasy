--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Scroll")
require("lib/game/ctrl/Actor")
require("lib/game/dirs/KeybDir")
require("lib/game/dirs/PhysDir")
require("lib/game/dirs/RuleDir")
require("lib/game/dirs/ActorDir")

Scene = Class {  
  DELTA = 0.1,
  
  graphics = Dependency("graphics"),
  
  fps = Property("_fps"),
  off = Property("_off"),
  lim = Property("_lim"),
  
  time = nil,
  delta = nil,
  frame = nil,

  physdir = nil,
  ruledir = nil,
  scrolls = nil,
  actors = nil,
  
  create = function(this, init)
    this.physdir = PhysDir.new(init and init.phys)
    this.ruledir = RuleDir.new(init and init.rules)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:fps(init and init.fps or 24)    
    
    this.time = 0
    this.delta = 0
    this.frame = 0

    this.scrolls = List(Scroll).new()
    this.actors = List(Actor).new()
  end,
  
  draw = function(this)
    this.scrolls:each(function(i, scroll) scroll:draw(this) end)
    this.actors:each(function(i, actor) actor:draw(this) end)
  end,
  
  update = function(this, delta)
    this.ruledir:update{scene = this, Math = Math}
  
    this.delta = delta
    this.frame = delta * this._fps
    this.time = this.time + delta

    this.scrolls:each(function(i, scroll)
      scroll:update(this)
    end)
      
    this.actors:each(function(i, actor)
      this.physdir:update{actor = actor, scene = this}
      actor:update(this)
    end)
  end,
  
  addKeyb = function(this, actor, init) actor:add(KeybDir.new(init)) end,
  addRules = function(this, actor, init) actor:add(ActorDir.new(init)) end,
    
  getActors = function(this, func)
    if func then return this.actors:filter(func) else return this.actors end
  end,
  
  getHit = function(this, hit, func)
    return this.actors:filter(function(actor) return func(actor) and this:isHit(hit, actor) end)
  end,

  isHit = function(this, hit, actor)
    local box, off = actor:hitbox(), this:off()
    box.x, box.y = box.x + off.x, box.y + off.y
    return Math.Isect(hit, box)
  end,

}
