--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScrollDraw = Class {
  resource = Dependency("resource"),
  graphics = Dependency("graphics"),
  window = Dependency("window"),
  
  scroll = nil,
  quad = nil,
  
  create = function(this, init)
    ImageDraw.create(this, init)
    
    local w, h = this.drawable:getWidth(), this.drawable:getHeight()
    this.quad = this.graphics.newQuad(0, 0, 0, 0, w, h)
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
}
