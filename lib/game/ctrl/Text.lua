--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Graphic")
require("lib/game/data/TextData")
require("lib/game/draw/TextDraw")

Text = Class {
  super = Graphic,
  
  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = TextDraw.new(init)
    this.data = TextData.new(init)
  end,
    
  draw = function(this, parent)
    this.drawable:draw(this.data, parent)
    Graphic.draw(this, parent)
  end,
}