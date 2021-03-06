--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/ui/frame/FrameData")
require("lib/game/ui/frame/FrameDraw")

Frame = Class {
  super = Graphic,
  
  drawable = nil,
  
  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = FrameDraw.new(init)
    this.data = FrameData.new(init)
  end,
  
  draw = function(this, area)
    this.drawable:draw(this.data, area)
    Graphic.draw(this, area)
  end,    
  
  border = function(this, val) return this.data:border(val) end,
}