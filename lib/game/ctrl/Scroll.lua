--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Image")
require("lib/game/data/ScrollData")
require("lib/game/draw/ScrollDraw")

Scroll = Class {
  super = Image,
  
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = ScrollDraw.new(init)
    this.data = ScrollData.new(init)
  end,
  
  draw = function(this, offset)
    this.drawable:draw(this.data, offset)
  end,  
}
