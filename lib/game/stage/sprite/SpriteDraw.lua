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
    local dim = spriteData:dim()
    local pad = spriteData:pad()
    local pos = actorData:pos()
    local flip = actorData:flip()
    local off = scene:off()
    local ratio = scene:ratio()
    
    if pad.x >= 0 and pad.x <= 1 then padx = dim.w * pad.x else padx = pad.x end
    if pad.y >= 0 and pad.y <= 1 then pady = dim.h * pad.y else pady = pad.y end
    
    local x, y = off.x + (pos.x * ratio.x), off.y + (pos.y * ratio.y) + (pos.z * ratio.z)
    local w, h = dim.w, dim.h
    local ow, oh = padx % (dim.w +1), pady % (dim.h +1)
    
    this.graphics.drawq(this.drawable, this.quads[frame], x, y, 0, flip.h, flip.v, ow, oh)
  end,
  
  getWidth = function(this) return this.drawable:getWidth() end,
  getHeight = function(this) return this.drawable:getHeight() end,
}
