--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/GraphicData")

Group = Class {
  items = nil,
  data = nil,
  
  create = function(this, init)
    this.data = GraphicData.new(init)
    this.items = init.items or {}
  end,
  
  draw = function(this, group, game)
    List.each(this.items, function(item) item:draw(this, game) end)
  end,
  
  step = function(this, group, game)
    List.each(this.items, function(item) item:step(this, game) end)
  end,
  
  update = function(this, delta, group, game)
    List.each(this.items, function(item) item:update(delta, this, game) end)
  end,
  
  add = function(this, item) List.add(this.items, item) end,
  rem = function(this, item) List.rem(this.items, item) end,
  pos = function(this, val) return this.data:pos(val) end,
}