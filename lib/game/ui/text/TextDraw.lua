--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicDraw")

TextDraw = Class {
  super = GraphicDraw,
  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  image = Dependency("image"),
  
  font = nil,

  create = function(this, init)
    local fontName = init and init.res
    this.font = this.resource:get("font", fontName)
  end,
  
  doDraw = function(this, data, x, y, w, h)
    this.graphics.setFont(this.font)
    this.graphics.printf(data:txt(), x, y, w, data:align())
  end,
}