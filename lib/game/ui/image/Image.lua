--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/Graphic")
require("lib/game/ui/image/ImageDraw")
require("lib/game/fx/ImageFX")

Image = Class {
  super = Graphic,

  create = function(this, init)
    Graphic.create(this, init)
    this.drawable = ImageDraw.new(init)
  end,
  
  draw = function(this, parent)
    this.drawable:drawBg(this.data, parent)
    Graphic.draw(this, parent)
    this.drawable:drawFg(this.data, parent)
  end,    
  
  img = function(this, val) this.drawable:img(val) end,
  pal = function(this, val) this.drawable:pal(val) end,
}