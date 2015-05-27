--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/draw/GraphicDraw")

FrameDraw = Class {
  super = GraphicDraw,
  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  image = Dependency("image"),
  
  drawables = nil,
  quads = nil,

  create = function(this, init)
    local imageName = init and init.res
    local b = init.border
      
    local images = {}
    this.quads = {}
    this.drawables = {}
    
    local imageData = this.resource:get("image", imageName)
    local w, h = imageData:getWidth(), imageData:getHeight()
    local wb, hb = w - 2*b, h - 2*b
    
    images.bg = this.resource:getFx("image", imageName)("bg", this:border(b, b, wb, hb))
    images.ul = this.resource:getFx("image", imageName)("ul", this:border(0, 0, b, b))
    images.ur = this.resource:getFx("image", imageName)("ur", this:border(w - b, 0, b, b))
    images.dl = this.resource:getFx("image", imageName)("dl", this:border(0, h - b, b, b))
    images.dr = this.resource:getFx("image", imageName)("dr", this:border(w - b, h - b, b, b))
    images.u  = this.resource:getFx("image", imageName)("u",  this:border(b, 0, wb, b))
    images.d  = this.resource:getFx("image", imageName)("d",  this:border(b, h - b, wb, b))
    images.l  = this.resource:getFx("image", imageName)("l",  this:border(0, b, b, hb))
    images.r  = this.resource:getFx("image", imageName)("r",  this:border(w - b, b, b, hb))
    this.drawables.bg = this.graphics.newImage(images.bg)
    this.drawables.ul = this.graphics.newImage(images.ul)
    this.drawables.ur = this.graphics.newImage(images.ur)
    this.drawables.dl = this.graphics.newImage(images.dl)
    this.drawables.dr = this.graphics.newImage(images.dr)
    this.drawables.u = this.graphics.newImage(images.u)
    this.drawables.d = this.graphics.newImage(images.d)
    this.drawables.l = this.graphics.newImage(images.l)
    this.drawables.r = this.graphics.newImage(images.r)
    this.drawables.bg:setWrap('repeat', 'repeat')
    this.drawables.u:setWrap('repeat', 'repeat')
    this.drawables.d:setWrap('repeat', 'repeat')
    this.drawables.l:setWrap('repeat', 'repeat')
    this.drawables.r:setWrap('repeat', 'repeat')
    this.quads.bg = this.graphics.newQuad(0, 0, w, h, w, h)
    this.quads.w = this.graphics.newQuad(0, 0, w, b, w, b)
    this.quads.h = this.graphics.newQuad(0, 0, b, h, b, h)
  end,
  
  border = function(this, x, y, w, h) return function(src)
    local dst = this.image.newImageData(w, h)
    dst:paste(src, 0, 0, x, y, w, h)
    return dst
  end
  end,

  doDraw = function(this, data, x, y, w, h)
    local b = data:border()
    
    this.quads.bg:setViewport(0, 0, w, h, w, h)
    this.graphics.drawq(this.drawables.bg, this.quads.bg, x, y)    
    
    this.quads.w:setViewport(0, 0, w, b, w, b)
    this.quads.h:setViewport(0, 0, b, h, b, h)
    this.graphics.drawq(this.drawables.u, this.quads.w, x, y - b)
    this.graphics.drawq(this.drawables.d, this.quads.w, x, y + h)
    this.graphics.drawq(this.drawables.l, this.quads.h, x - b, y)
    this.graphics.drawq(this.drawables.r, this.quads.h, x + w, y)
    this.graphics.draw(this.drawables.ul, x - b, y - b)
    this.graphics.draw(this.drawables.ur, x + w, y - b)
    this.graphics.draw(this.drawables.dl, x - b, y + h)
    this.graphics.draw(this.drawables.dr, x + w, y + h)
  end,  
}