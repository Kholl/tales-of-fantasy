--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/scene/SceneScript")
require("lib/game/stage/scene/SceneData")
require("lib/game/stage/scroll/Scroll")
require("lib/game/stage/actor/Actor")
require("lib/game/dlgs/PhysDlg")
require("lib/game/dlgs/ScriptDlg")

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
    
    this.scrolls = init.scrolls or {}
    this.actors = init.actors or {}
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this, area)
    List.each(this.scrolls, function(scroll) scroll:draw(this) end)
    List.each(this.actors, function(actor) actor:draw(this) end)
  end,
  
  step = function(this, game)
    this.script:step(this, this, game)
    List.each(this.scrolls, function(scroll) scroll:step(this, game) end)
    List.each(this.actors, function(actor) actor:step(this, game) end)
    List.each(this.actors, function(actor) this.phys:step(actor, this, game) end)      
  end,
  
  update = function(this, delta, game)
    local lastframe = math.floor(this.data._frame)
    
    -- Move time to game context
    this:time(delta + this.data._time)
    this:frame(this.data._time * game.fps)
    this.data._step = (math.floor(this.data._frame) > lastframe)
        
    this.script:update(delta, this, game)
    List.each(this.scrolls, function(scroll) scroll:update(delta, this, game) end)
    List.each(this.actors, function(actor) actor:update(delta, this, game) end)
    List.each(this.actors, function(actor) this.phys:update(delta, actor, this, game) end)      

    if this.data._step then this:step(game) end
  end,
  
  off = function(this, val) return this.data:off(val) end,
  lim = function(this, val) return this.data:lim(val) end,
  ratio = function(this, val) return this.data:ratio(val) end,
  time = function(this, val) return this.data:time(val) end,
  frame = function(this, val) return this.data:frame(val) end,
  
  addScroll = function(this, init, custom) return List.add(this.scrolls, Scroll.new(init, custom)) end,
  addActor = function(this, init, custom) return List.add(this.actors, Actor.new(init, custom)) end,
    
  getActors = function(this, func)
    if func then return List.filter(this.actors, func) else return this.actors end
  end,
  
  getHits = function(this, actor)
    return this:getActors(function(other)
      return not (actor == other) and ActorScript.isHit()(actor, this, other)
    end)
  end,
}
