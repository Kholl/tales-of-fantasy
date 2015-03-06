--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Scroll")
require("lib/game/ctrl/Actor")
require("lib/game/ctrl/Image")
require("lib/game/ctrl/dlgs/PhysDlg")
require("lib/game/ctrl/dlgs/ScriptDlg")

Scene = Class {    
  graphics = Dependency("graphics"),
  
  fps = Property("_fps"),
  off = Property("_off"),
  lim = Property("_lim"),
  ratio = Property("_ratio"),
  
  time = nil,
  delta = nil,
  frame = nil,

  script = nil,
  phys = nil,
  
  scrolls = nil,
  actors = nil,
  
  create = function(this, init)
    this.script = ScriptDlg.new(init)
    this.phys = PhysDlg.new(init)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:fps(init and init.fps or 24)    
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    
    this.time = 0
    this.delta = 0
    this.frame = 0

    this.scrolls = {}
    this.actors = {}
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this)
    List.each(this.scrolls, function(scroll) scroll:draw(this) end)
    List.each(this.actors, function(actor) actor:draw(this) end)
  end,
  
  update = function(this, delta)
    this.script:update(this)
  
    this.delta = delta
    this.time = this.time + delta
    this.frame = delta * this._fps
      
    List.each(this.scrolls, function(scroll) scroll:update(this) end)      
    List.each(this.actors, function(actor) this.phys:update(actor, this) end)
    List.each(this.actors, function(actor) actor:update(this) end)
  end,
  
  addScroll = function(this, init) return List.add(this.scrolls, Scroll.new(init)) end,
  addActor = function(this, init) return List.add(this.actors, Actor.new(init)) end,
    
  getActors = function(this, func)
    if func then return List.filter(this.actors, func) else return this.actors end
  end,
  
  getHits = function(this, actor)
    return List.filter(this.actors, function(other)
      return not (actor == other) and actor:isHit(other)
    end)
  end,
}
