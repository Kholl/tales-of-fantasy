--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/stage/scene/SceneRules")
require("lib/game/stage/scene/SceneData")
require("lib/game/stage/scene/Physics")
require("lib/game/stage/scroll/Scroll")
require("lib/game/stage/actor/Actor")

Scene = Class {
  super = Graphic,
  graphics = Dependency("graphics"),
  
  data = nil,
  phys = nil,
  
  scrolls = nil,
  actors = nil,
  list = nil,
  
  create = function(this, init)
    this.data = SceneData.new(init)
    this.phys = Physics.new(init)
    
    this.scrolls = init.scrolls or {}
    this.actors = init.actors or {}
    this.list = init.list or {}
  end,
  
  draw = function(this, parent)
    local area = this.data:area(parent)
    local color = this.data:color()
    local alpha = this.data:alpha()
    local x, y, w, h = area.x, area.y, area.w, area.h
    
    this.graphics.setScissor(area.vx, area.vy, area.vw, area.vh)  
    this.graphics.setColor(color.r * 255, color.g * 255, color.b * 255, alpha * 255)
    
    List.each(this.scrolls, function(scroll) scroll:draw(this) end)
    List.each(this.list, function(item) item:draw(this) end)
    List.each(this.actors, function(actor) actor:drawShadow(this) end)
    
    List.each(List.sorted(this.actors, function(actor) return actor:pos().z end),
      function(actor) actor:draw(this) end)
    
    this.graphics.setColor(255, 255, 255, 255)    
    this.graphics.setScissor()     
  end,
  
  step = function(this, game)
    List.each(this.scrolls, function(scroll) scroll:step(this, game) end)
    List.each(this.actors, function(actor) actor:step(this, game) end)
    List.each(this.actors, function(actor) this.phys:step(actor, this, game) end)      
    List.each(this.list, function(item) item:step(this, game) end)
  end,
  
  update = function(this, delta, parent, game)
    this.data:update(delta, this, game)
    List.each(this.scrolls, function(scroll) scroll:update(delta, this, game) end)
    List.each(this.actors, function(actor) actor:update(delta, this, game) end)
    List.each(this.actors, function(actor) this.phys:update(delta, actor, this, game) end)      
    List.each(this.list, function(item) item:update(delta, this, game) end)

    if this.data:onFrame() then this:step(game) end
  end,
  
  off = function(this, val) return this.data:off(val) end,
  lim = function(this, val) return this.data:lim(val) end,
  time = function(this, val) return this.data:time(val) end,
  ratio = function(this, val) return this.data:ratio(val) end,
  state = function(this, val) return this.data:state(val) end,
  
  onFrame = function(this) return this.data:onFrame() end,
  
  scroll = function(this, key) return this.scrolls[key] end,
  actor = function(this, key) return this.actors[key] end,
  addScroll = function(this, key, init, custom) this.scrolls[key] = Scroll.new(init, custom) end,
  addActor = function(this, key, init, custom) this.actors[key] = Actor.new(init, custom) end,
  
  getActors = function(this, filter) return List.filter(this.actors, filter) end,
}
