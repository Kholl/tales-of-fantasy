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
    
  draw = function(this, area)
    Graphic.draw(this, area)
    this.drawable:draw(this.data, area)
  end,
  
  txt = function(this, val) this.data:txt(val) end,    
  fit = function(this, val) this.data:fit(val) end,
  align = function(this, val) this.data:align(val) end,
}