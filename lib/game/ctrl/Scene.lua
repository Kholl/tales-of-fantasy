--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/SceneData")
require("lib/game/script/SceneScript")
require("lib/game/ctrl/Scroll")
require("lib/game/ctrl/Actor")
require("lib/game/ctrl/dlgs/PhysDlg")
require("lib/game/ctrl/dlgs/ScriptDlg")

Scene = Class {    
  data = nil,
  phys = nil,
  script = nil,
  
  scrolls = nil,
  actors = nil,
  
  create = function(this, init)
    this.data = SceneData.new(init)
    this.phys = PhysDlg.new(init)
    this.script = ScriptDlg.new(init)
    
    this.scrolls = {}
    this.actors = {}
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this, game)
    List.each(this.scrolls, function(scroll) scroll:draw(this) end)
    List.each(this.actors, function(actor) actor:draw(this) end)
  end,
  
  update = function(this, game)
    this.script:update(this)
  
    this:time(this.data._delta + this.data._time)
    this:frame(this.data._delta * this.data._fps)
      
    List.each(this.scrolls, function(scroll) scroll:update(this) end)      
    List.each(this.actors, function(actor) actor:update(this) end)
    List.each(this.actors, function(actor) this.phys:update(actor, this) end)
  end,
  
  fps = function(this, val) return this.data:fps(val) end,
  off = function(this, val) return this.data:off(val) end,
  lim = function(this, val) return this.data:lim(val) end,
  ratio = function(this, val) return this.data:ratio(val) end,
  delta = function(this, val) return this.data:delta(val) end,
  time = function(this, val) return this.data:time(val) end,
  frame = function(this, val) return this.data:frame(val) end,
  
  addScroll = function(this, init) return List.add(this.scrolls, Scroll.new(init)) end,
  addActor = function(this, init) return List.add(this.actors, Actor.new(init)) end,
    
  getActors = function(this, func)
    if func then return List.filter(this.actors, func) else return this.actors end
  end,
  
  getHits = function(this, actor)
    return this:getActors(function(other)
      return not (actor == other) and ActorScript.isHit()(actor, this, other)
    end)
  end,
}
