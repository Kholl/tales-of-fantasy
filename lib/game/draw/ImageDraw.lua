--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageDraw = Class {
  FORMAT = "%s%s",
  
  filesystem = Dependency("filesystem"),
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  
  drawable = nil,
  
  create = function(this, init)
    local resourceName = init and init.res    
      
    if init.pmap then
      local resourceOrig = resourceName
      resourceName = ImageDraw.FORMAT:format(resourceName, init.pmap.name)
      local resource = this.resource:get("image", resourceName)
      
      if not resource then
        resource = this.resource:safeload("image", resourceOrig)
        resource:mapPixel(init.pmap.func)
        this.filesystem.mkdir(resourceName)
        this.filesystem.remove(resourceName)
        resource:encode(resourceName)
        this.resource:set(resourceName, resource)
      end
    end

    local resource = assert(this.resource:get("image", resourceName), resourceName)
    this.drawable = this.graphics.newImage(resource)
    this.drawable:setWrap("repeat", "repeat")
    
    local w, h = this.drawable:getWidth(), this.drawable:getHeight()
    this.quad = this.graphics.newQuad(0, 0, 0, 0, w, h)
  end,
  
  draw = function(this, data)
    local pos = data:pos()
    local dim = data:dim()
    local col = data:col()
    
    local r, g, b, a = this.graphics.getColor()
    this.quad:setViewport(0, 0, dim.w, dim.h)
    this.graphics.setColor(col.r, col.g, col.b)
    this.graphics.drawq(this.drawable, this.quad, pos.x, pos.y)
    this.graphics.setColor(r, g, b, a)
  end,
}
