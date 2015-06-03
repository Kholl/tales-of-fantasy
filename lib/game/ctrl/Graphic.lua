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
    local area = this.data:area(parent)
        
    this.graphics.setScissor(area.x, area.y, area.w, area.h)
    List.each(this.list, function(item) item:draw(area) end)
    this.graphics.setScissor()
  end,
  
  step = function(this, group, game)
    List.each(this.list, function(item) item:step(this, game) end)
  end,
  
  update = function(this, delta, group, game)
    List.each(this.list, function(item) item:update(delta, this, game) end)
  end,

  add = function(this, item) List.add(this.list, item) end,
  rem = function(this, item) List.rem(this.list, item) end,  
}