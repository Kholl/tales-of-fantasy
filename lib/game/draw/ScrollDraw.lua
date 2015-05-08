--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScrollDraw = Class {
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  window = Dependency("window"),
  
  drawable = nil,  
  quad = nil,
  
  create = function(this, init)
    local imageName = init and init.res    
    local image
    
    if init.pmap
      then image = this.resource:getFx("image", imageName)(init.pmap.name, init.pmap.func)
      else image = this.resource:get("image", imageName)
    end
    
    this.drawable = this.graphics.newImage(image)
    
    local w, h = this.drawable:getWidth(), this.drawable:getHeight()
    this.quad = this.graphics.newQuad(0, 0, 0, 0, w, h)
  end,
  
  draw = function(this, data, scene, game)
    local pos = data:pos()
    local mul = data:mul()
    local scr = data:scr()
    local off = scene:off()
    
    local w, h = this.graphics.getWidth(), this.graphics.getHeight()
    local x = ((off.x * mul.x) + pos.x)
    local y = ((off.y * mul.y) + pos.y)
    this.quad:setViewport(0, 0, w - x, h - y)    
    this.drawable:setWrap(scr.x, scr.y)
    this.graphics.drawq(this.drawable, this.quad, x, y)
  end,
}
