--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/GraphicData")

Graphic = Class {  
  graphics = Dependency("graphics"),
  
  list = nil,  
  data = nil,
  
  create = function(this, init)
    this.list = init.list or {}
    this.data = GraphicData.new(init)
  end,
  
  draw = function(this, parent)
    if this.data:hidden() then return end
    local x, y, w, h, b = this.data:area(parent)
    
    this.graphics.setScissor(x, y, w, h)
    this.graphics.translate(x, y)
    this.graphics.push()
    
    List.each(this.list, function(item) item:draw(this) end)
    
    this.graphics.setScissor()
    this.graphics.pop()
  end,
  
  step = function(this, group, game)
    List.each(this.list, function(item) item:step(this, game) end)
  end,
  
  update = function(this, delta, group, game)
    List.each(this.list, function(item) item:update(delta, this, game) end)
  end,

  add = function(this, item) List.add(this.list, item) end,
  rem = function(this, item) List.rem(this.list, item) end,  
  pos = function(this, val) return this.data:pos(val) end,
  dim = function(this, val) return this.data:dim(val) end,
}