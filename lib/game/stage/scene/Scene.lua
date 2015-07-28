--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/stage/scene/SceneData")
require("lib/game/stage/scroll/Scroll")
require("lib/game/stage/actor/Actor")
require("lib/game/dlgs/PhysDlg")
require("lib/game/dlgs/ScriptDlg")

Scene = Class {
  super = Graphic,
  graphics = Dependency("graphics"),
  
  data = nil,
  phys = nil,
  script = nil,
  
  scrolls = nil,
  actors = nil,
  list = nil,
  
  create = function(this, init)
    this.data = SceneData.new(init)
    this.phys = PhysDlg.new(init)
    this.script = ScriptDlg.new(init)
    
    this.scrolls = init.scrolls or {}
    this.actors = init.actors or {}
    this.list = init.list or {}
    
    if init.start then init.start(this) end
  end,
  
  draw = function(this, parent)
    local area = this.data:area(parent)
    local color = this.data:color()
    local alpha = this.data:alpha()
    local x, y, w, h = area.x, area.y, area.w, area.h
    
    this.graphics.setScissor(area.vx, area.vy, area.vw, area.vh)  
    this.graphics.setColor(color.r * 255, color.g * 255, color.b * 255, alpha * 255)
    
    List.each(this.scrolls, function(scroll) scroll:draw(this) end)
    List.each(this.actors, function(actor) actor:draw(this) end)
    List.each(this.list, function(item) item:draw(this) end)
    
    this.graphics.setColor(255, 255, 255, 255)    
    this.graphics.setScissor()     
  end,
  
  step = function(this, game)
    this.script:step(this, this, game)
    List.each(this.scrolls, function(scroll) scroll:step(this, game) end)
    List.each(this.actors, function(actor) actor:step(this, game) end)
    List.each(this.actors, function(actor) this.phys:step(actor, this, game) end)      
  end,
  
  update = function(this, delta, parent, game)
    local lastframe = math.floor(this.data._frame)
    
    -- Move time to game context
    this:time(delta + this.data._time)
    this:frame(this.data._time * game.fps)
    this.data._step = (math.floor(this.data._frame) > lastframe)
        
    this.script:update(delta, this, game)
    List.each(this.scrolls, function(scroll) scroll:update(delta, this, game) end)
    List.each(this.actors, function(actor) actor:update(delta, this, game) end)
    List.each(this.actors, function(actor) this.phys:update(delta, actor, this, game) end)      
    List.each(this.list, function(item) item:update(delta, this, game) end)

    if this.data._step then this:step(game) end
  end,
  
  off = function(this, val) return this.data:off(val) end,
  lim = function(this, val) return this.data:lim(val) end,
  ratio = function(this, val) return this.data:ratio(val) end,
  time = function(this, val) return this.data:time(val) end,
  frame = function(this, val) return this.data:frame(val) end,
  
  scroll = function(this, key) return this.scrolls[key] end,
  actor = function(this, key) return this.actors[key] end,
  addScroll = function(this, key, init, custom) this.scrolls[key] = Scroll.new(init, custom) end,
  addActor = function(this, key, init, custom) this.actors[key] = Actor.new(init, custom) end,
    
  getActors = function(this, func)
    if func then return List.filter(this.actors, func) else return this.actors end
  end,
  
  getHits = function(this, actor, game)
    return this:getActors(function(other)
      return ActorScript.isTargetHit{actor:state()}(actor, this, game, other)
    end)
  end,
}
