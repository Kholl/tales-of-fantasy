--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/draw/GraphicDraw")

ImageDraw = Class {
  super = GraphicDraw,
  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  
  drawable = nil,
  quad = nil,

  create = function(this, init)
    GraphicDraw.create(this, init)
    
    local imageName = init and init.res
    local image = this.resource:get("image", imageName)
    local w, h = image:getWidth(), image:getHeight()
    
    this.drawable = this.graphics.newImage(image)
    this.quad = this.graphics.newQuad(0, 0, w, h, w, h)
  end,

  doDraw = function(this, data, x, y, w, h)
    this.graphics.drawq(this.drawable, this.quad, x, y)
  end,  
}