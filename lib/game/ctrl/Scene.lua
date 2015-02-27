--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Scroll")
require("lib/game/ctrl/Actor")
require("lib/game/ctrl/Image")
require("lib/game/ctrl/Text")
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
  iface = nil,
  
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

    this.scrolls = L{}
    this.actors = L{}
    this.iface = init.iface or Nil
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this)
    this.scrolls:each(function(scroll) scroll:draw(this) end)
    this.actors:each(function(actor) actor:draw(this) end)
    this.iface:draw()
  end,
  
  update = function(this, delta)
    this.script:update(this)
  
    this.delta = delta
    this.time = this.time + delta
    this.frame = delta * this._fps
      
    this.scrolls:each(function(scroll) scroll:update(this) end)      
    this.actors:each(function(actor) this.phys:update(actor, this) end)
    this.actors:each(function(actor) actor:update(this) end)
  
    this.iface:update()
  end,
  
  addScroll = function(this, init) return this.scrolls:add(Scroll.new(init)) end,
  addActor = function(this, init) return this.actors:add(Actor.new(init)) end,
    
  getActors = function(this, func)
    if func then return this.actors:filter(func) else return this.actors end
  end,
  
  getHits = function(this, actor)
    return this.actors:filter(function(other)
      return not (actor == other) and actor:isHit(other)
    end)
  end,
}
