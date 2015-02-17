--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Scroll")
require("lib/game/ctrl/Actor")
require("lib/game/ctrl/Image")
require("lib/game/ctrl/Text")
require("lib/game/dlgs/KeybDlg")
require("lib/game/dlgs/PhysDlg")
require("lib/game/dlgs/SceneDlg")
require("lib/game/dlgs/ActorDlg")

Scene = Class {    
  graphics = Dependency("graphics"),
  
  fps = Property("_fps"),
  off = Property("_off"),
  lim = Property("_lim"),
  ratio = Property("_ratio"),
  
  time = nil,
  delta = nil,
  frame = nil,

  scenedlg = nil,
  physdlg = nil,
  scrolls = nil,
  actors = nil,
  iface = nil,
  
  create = function(this, init)
    this.scenedlg = SceneDlg.new(init and init.rules)
    this.physdlg = PhysDlg.new(init and init.phys)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:fps(init and init.fps or 24)    
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    
    this.time = 0
    this.delta = 0
    this.frame = 0

    this.scrolls = List(Scroll).new()
    this.actors = List(Actor).new()
    this.iface = init.iface or Nil
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this)
    this.scrolls:each(function(scroll) scroll:draw(this) end)
    this.actors:each(function(actor) actor:draw(this) end)
    this.iface:draw()
  end,
  
  update = function(this, delta)
    this.scenedlg:update{
      scene = this,
      Math = Math,
      List = List,
      Each = Each,
      Find = Find,
      Copy = Copy,
      Range = Range,
      Game = Game}
  
    this.delta = delta
    this.time = this.time + delta
    this.frame = delta * this._fps
      
    this.scrolls:each(function(scroll) scroll:update(this) end)      
    this.actors:each(function(actor)
      this.physdlg:update{actor = actor, scene = this}
      actor:update(this)
    end)
    this.iface:update()
  end,
    
  getActors = function(this, func)
    if func then return this.actors:filter(func) else return this.actors end
  end,
  
  getHits = function(this, actor)
    return this.actors:filter(function(other)
      return not (actor == other) and actor:isHit(other)
    end)
  end,
}
