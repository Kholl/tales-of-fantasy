--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Graphic")
require("lib/game/data/ImageData")
require("lib/game/draw/ImageDraw")

Image = Class {
  super = Graphic,

  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = ImageDraw.new(init)
    this.data = ImageData.new(init)
  end,
  
  draw = function(this, parent)
    Graphic.draw(this, parent)
    this.drawable:draw(this.data, parent)
  end,    
}