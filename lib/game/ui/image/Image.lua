--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/ui/image/ImageData")
require("lib/game/ui/image/ImageDraw")

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