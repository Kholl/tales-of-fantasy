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
    this.fit = {w = nil, h = nil}
  end,
  
  doDraw = function(this, data, x, y, w, h)
    local txt = data:txt()
    
    this.graphics.setFont(this.font)
    this.graphics.printf(txt, x, y, w, data:align())
    
    local fit, dim = data:fit(), data:dim()
    
    if fit.w or fit.h then 
      local fitw, nlines = this.font:getWrap(txt, w)
      local fith = nlines * this.font:getHeight()
      if fit.w then dim.w = fitw end
      if fit.h then dim.h = fith end
    end
  end,
}