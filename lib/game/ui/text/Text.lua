--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/ui/text/TextData")
require("lib/game/ui/text/TextDraw")

Text = Class {
  super = Graphic,
  
  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = TextDraw.new(init)
    this.data = TextData.new(init)
  end,
    
  draw = function(this, parent)
    Graphic.draw(this, parent)
    this.drawable:draw(this.data, parent)
  end,
}