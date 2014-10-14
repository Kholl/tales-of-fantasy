--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require "lib/game/draw/ImageDraw"

SpriteDraw = Class {  
  super = ImageDraw,
  graphics = Dependency("graphics"),
  
  quads = nil,
  
  create = function(this, init)
    ImageDraw.create(this, init)
    
    local nframes = init and init.nframes or 1
    local hframes = init and init.hframes or nframes

    local div = {
      w = math.min(nframes, hframes),
      h = math.ceil(nframes / hframes)}
    
    local dim = init and init.dim or {w = 0, h = 0}    
    
    this.quads = {}
    
    Range(0, nframes-1, function(i)
      local x = (i % hframes) * dim.w
      local y = math.floor(i / hframes) * dim.w
      
      this.quads[i] = this.graphics.newQuad(
        x, y,
        dim.w, dim.h,
        this.drawable:getWidth(),
        this.drawable:getHeight())
    end)
  end,
  
  draw = function(this, spriteData, imageData, scene)
    local frame = spriteData:get()
    local dim = spriteData:dim()
    local pos = imageData:pos()
    local sca = imageData:sca()
    local off = scene:off()
    
    this.graphics.drawq(this.drawable, this.quads[frame],
      off.x + pos.x, off.y + pos.y + pos.z, 0, sca.x, sca.y, dim.w * 0.5, dim.h)
  end,
}
