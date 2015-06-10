--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicDraw")

FrameDraw = Class {
  super = GraphicDraw,
  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  image = Dependency("image"),
  
  drawables = nil,
  quads = nil,

  create = function(this, init)
    GraphicDraw.create(this, init)
    
    local bdImageName = init and init.res
    local b = init.bdSize
      
    local bdImage = this.resource:get("image", bdImageName)
    local w, h = bdImage:getWidth(), bdImage:getHeight()
    local wb, hb = w - 2*b.w, h - 2*b.h
    
    local images = {}
    images.ul = this.resource:getFx("image", bdImageName)("ul", this:border(0, 0, b.w, b.h))
    images.ur = this.resource:getFx("image", bdImageName)("ur", this:border(w - b.w, 0, b.w, b.h))
    images.dl = this.resource:getFx("image", bdImageName)("dl", this:border(0, h - b.h, b.w, b.h))
    images.dr = this.resource:getFx("image", bdImageName)("dr", this:border(w - b.w, h - b.h, b.w, b.h))
    images.u  = this.resource:getFx("image", bdImageName)("u",  this:border(b.w, 0, wb, b.h))
    images.d  = this.resource:getFx("image", bdImageName)("d",  this:border(b.w, h - b.h, wb, b.h))
    images.l  = this.resource:getFx("image", bdImageName)("l",  this:border(0, b.w, b.w, hb))
    images.r  = this.resource:getFx("image", bdImageName)("r",  this:border(w - b.w, b.h, b.w, hb))
    
    this.draws = {}
    this.draws.ul = this.graphics.newImage(images.ul)
    this.draws.ur = this.graphics.newImage(images.ur)
    this.draws.dl = this.graphics.newImage(images.dl)
    this.draws.dr = this.graphics.newImage(images.dr)
    this.draws.u = this.graphics.newImage(images.u)
    this.draws.d = this.graphics.newImage(images.d)
    this.draws.l = this.graphics.newImage(images.l)
    this.draws.r = this.graphics.newImage(images.r)
    this.draws.u:setWrap('repeat', 'repeat')
    this.draws.d:setWrap('repeat', 'repeat')
    this.draws.l:setWrap('repeat', 'repeat')
    this.draws.r:setWrap('repeat', 'repeat')
    
    this.quads = {}
    this.quads.w = this.graphics.newQuad(0, 0, w, b.h, w, b.h)
    this.quads.h = this.graphics.newQuad(0, 0, b.w, h, b.w, h)
  end,
  
  border = function(this, x, y, w, h) return function(src)
    local dst = this.image.newImageData(w, h)
    dst:paste(src, 0, 0, x, y, w, h)
    return dst
  end
  end,

  doDraw = function(this, data, x, y, w, h)
    local b = data:bdSize()
    
    this.quads.w:setViewport(0, 0, w, b.h, w, b.h)
    this.quads.h:setViewport(0, 0, b.w, h, b.w, h)
    this.graphics.drawq(this.draws.u, this.quads.w, x, y - b.h)
    this.graphics.drawq(this.draws.d, this.quads.w, x, y + h)
    this.graphics.drawq(this.draws.l, this.quads.h, x - b.w, y)
    this.graphics.drawq(this.draws.r, this.quads.h, x + w, y)
    this.graphics.draw(this.draws.ul, x - b.w, y - b.h)
    this.graphics.draw(this.draws.ur, x + w, y - b.h)
    this.graphics.draw(this.draws.dl, x - b.w, y + h)
    this.graphics.draw(this.draws.dr, x + w, y + h)
  end,  
}