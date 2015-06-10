--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Graphic")
require("lib/game/data/FrameData")
require("lib/game/draw/FrameDraw")

Frame = Class {
  super = Graphic,
  
  drawable = nil,
  
  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = FrameDraw.new(init)
    this.data = FrameData.new(init)
  end,
  
  draw = function(this, parent)
    this.drawable:draw(this.data, parent)
    Graphic.draw(this, parent)
  end,    
  
  border = function(this, val) return this.data:border(val) end,
}