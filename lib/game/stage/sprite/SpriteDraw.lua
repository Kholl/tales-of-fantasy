--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SpriteDraw = Class {  
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  
  drawable = nil,
  quads = nil,
  
  create = function(this, init)
    local path = init and init.path
    
    local imageName
    imageName = init and init.res    
    imageName = path .. "/" .. imageName .. ".png"
    
    local image
    if init.pmap
      then image = this.resource:getFx("image", imageName)(init.pmap.name, init.pmap.func)
      else image = this.resource:get("image", imageName)
    end
    
    this.drawable = this.graphics.newImage(image)
    
    local nframes = init and init.nframes or 1

    local w, h = this.drawable:getWidth(), this.drawable:getHeight()
    local dim = {w = w / nframes, h = h}
    
    this.quads = {}
    
    for i = 0, nframes -1 do
      local x, y = i * dim.w, 0
      this.quads[i] = this.graphics.newQuad(x, y, dim.w, dim.h, w, h)
    end
  end,
  
  draw = function(this, spriteData, actorData, scene)
    local frame = spriteData:frame()
    local x, y, w, h, sw, sh, ow, oh = this.area(spriteData, actorData, scene)
    
    this.graphics.drawq(this.drawable, this.quads[frame], x, y, 0, sw, sh, ow, oh)
  end,
  
  drawShadow = function(this, spriteData, actorData, scene)
    local frame = spriteData:frame()
    local ratio = scene:ratio()
    local x, y, w, h, sw, sh, ow, oh = this.area(spriteData, actorData, scene, {x = 1, y = 0, z = 1})
    
    local r, g, b, a = this.graphics.getColor()
    this.graphics.setColor(0, 0, 0, 96)
    this.graphics.drawq(this.drawable, this.quads[frame], x, y, 0, sw * ratio.x, -sh * ratio.z, ow, oh)
    this.graphics.setColor(r, g, b, a)
  end,
  
  area = function(spriteData, actorData, scene, k)
    local dim = spriteData:dim()
    local pad = spriteData:pad()
    local pos = actorData:pos()
    local flip = actorData:flip()
    local off = scene:off()
    local ratio = scene:ratio()
    
    k = k or {x = 1, y = 1, z = 1}
    
    if pad.x >= 0 and pad.x <= 1 then padx = dim.w * pad.x else padx = pad.x end
    if pad.y >= 0 and pad.y <= 1 then pady = dim.h * pad.y else pady = pad.y end
    
    local x, y = off.x + (pos.x * ratio.x * k.x), off.y + (pos.y * ratio.y * k.y) + (pos.z * ratio.z * k.z)
    local w, h = dim.w, dim.h
    local ow, oh = padx % (dim.w +1), pady % (dim.h +1)
    
    return x, y, w, h, flip.h, flip.v, ow, oh
  end,
  
  getWidth = function(this) return this.drawable:getWidth() end,
  getHeight = function(this) return this.drawable:getHeight() end,
}
