--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

FrameDraw = Class {
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
    this.quads.bg = this.graphics.newQuad(0, 0, wb, hb, wb, hb)
    this.quads.u = this.graphics.newQuad(0, 0, wb, b, wb, b)
    this.quads.d = this.graphics.newQuad(0, 0, wb, b, wb, b)
    this.quads.l = this.graphics.newQuad(0, 0, b, hb, b, hb)
    this.quads.r = this.graphics.newQuad(0, 0, b, hb, b, hb)
  end,

  draw = function(this, data, group, game)
    local dim = data:dim()
    local pos = data:pos()
    local b = data:border()
    local off = group and group:pos() or {x = 0, y = 0}
    local x, y = pos.x + off.x, pos.y + off.y
    local w, h = math.ceil(dim.w), math.ceil(dim.h)
    local wb, hb = w - 2*b, h - 2*b
    
    this.quads.bg:setViewport(b, b, wb, hb)
    this.quads.u:setViewport(0, 0, wb, b)
    this.quads.d:setViewport(0, 0, wb, b)
    this.quads.l:setViewport(0, 0, b, hb)
    this.quads.r:setViewport(0, 0, b, hb)
    this.graphics.drawq(this.drawables.bg, this.quads.bg, x + b, y + b)
    this.graphics.drawq(this.drawables.u, this.quads.u, x + b, y)
    this.graphics.drawq(this.drawables.d, this.quads.d, x + b, y + h - b)
    this.graphics.drawq(this.drawables.l, this.quads.l, x, y + b)
    this.graphics.drawq(this.drawables.r, this.quads.r, x + w - b, y + b)
    this.graphics.draw(this.drawables.ul, x, y)
    this.graphics.draw(this.drawables.ur, x + w - b, y)
    this.graphics.draw(this.drawables.dl, x, y + h - b)
    this.graphics.draw(this.drawables.dr, x + w - b, y + h - b)
  end,
  
  border = function(this, x, y, w, h) return function(src)
    local dst = this.image.newImageData(w, h)
    dst:paste(src, 0, 0, x, y, w, h)
    return dst
  end
  end,
}