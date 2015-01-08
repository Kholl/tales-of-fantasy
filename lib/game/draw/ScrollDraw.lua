--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScrollDraw = Class {
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  window = Dependency("window"),
  
  scroll = nil,
  drawable = nil,
  quad = nil,
  
  create = function(this, init)
    local resource = (init and init.res)
    this.drawable = this.resource:get("image", resource)
    
    local size = this:size()
    this.quad = this.graphics.newQuad(0, 0, 0, 0, size.w, size.h)
  end,
  
  draw = function(this, data, scene)
    local pos = data:pos()
    local mul = data:mul()
    local off = scene:off()
    local scr = data:scr()
    
    local w, h = this.graphics:getMode()
    local x = ((off.x * mul.x) + pos.x)
    local y = ((off.y * mul.y) + pos.y)
    this.quad:setViewport(0, 0, w - x, h - y)    
    this.drawable:setWrap(scr.x, scr.y)
    this.graphics.drawq(this.drawable, this.quad, x, y)
  end,
    
  size = function(this)
    return {w = this.drawable:getWidth(), h = this.drawable:getHeight()}
  end,
}
