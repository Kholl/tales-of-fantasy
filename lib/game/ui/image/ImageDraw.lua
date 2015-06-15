--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicDraw")

ImageDraw = Class {
  super = GraphicDraw,
  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  
  drawable = nil,
  quad = nil,
  
  img = Property("_img", "reload"),
  pal = Property("_pal", "reload"),

  create = function(this, init)
    GraphicDraw.create(this, init)
    this._img = false
    this._pal = false
    this:img(init.img)
    this:pal(init.pal)
  end,

  doDraw = function(this, data, x, y, w, h)
    local dir = data:dir()
    this.graphics.drawq(this.drawable, this.quad, x + w/2, y + h/2, 0, dir.x, dir.y, w/2, h/2)
  end,  
    
  reload = function(this)    
    local image
    local pal = this:pal()
    local img = this:img()    
    
    if pal
      then image = this.resource:getFx("image", img)(pal, ImageFX.mapPixel(pal))
      else image = this.resource:get("image", img)
    end
  
    local w, h = image:getWidth(), image:getHeight()
    
    this.drawable = this.graphics.newImage(image)
    this.quad = this.graphics.newQuad(0, 0, w, h, w, h)
  end,
}