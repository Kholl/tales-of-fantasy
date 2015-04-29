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
    local imageName = init and init.res    
    local image
    
    if init.pmap
      then image = this.resource:getFx("image", imageName)(init.pmap.name, init.pmap.func)
      else image = this.resource:get("image", imageName)
    end
    
    this.drawable = this.graphics.newImage(image)
    
    local nframes = init and init.nframes or 1
    local hframes = init and init.hframes or nframes

    local div = {
      w = math.min(nframes, hframes),
      h = math.ceil(nframes / hframes)}
    
    local dim = init and init.dim or {w = 0, h = 0}    
    
    this.quads = {}
    
    for i = 0, nframes -1 do
      local x = (i % hframes) * dim.w
      local y = math.floor(i / hframes) * dim.w
      
      this.quads[i] = this.graphics.newQuad(
        x, y,
        dim.w, dim.h,
        this.drawable:getWidth(),
        this.drawable:getHeight())
    end
  end,
  
  draw = function(this, spriteData, imageData, scene, game)
    local frame = spriteData:get()
    local dim = spriteData:dim()
    local pos = imageData:pos()
    local dir = imageData:dir()
    local pad = spriteData:pad()
    local rad = spriteData:rad()
    local off = scene:off()
    local ratio = scene:ratio()
    
    if pad.x >= 0 and pad.x <= 1 then padx = dim.w * pad.x else padx = pad.x end
    if pad.y >= 0 and pad.y <= 1 then pady = dim.h * pad.y else pady = pad.y end
    
    this.graphics.drawq(this.drawable, this.quads[frame],
      off.x + (pos.x * ratio.x),
      off.y + (pos.y * ratio.y) + (pos.z * ratio.z), 0,
      dir.x, dir.y,
      padx % (dim.w +1), pady % (dim.h +1))
  end,
}
