--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicDraw = Class {
  graphics = Dependency("graphics"),
  
  bgDraw = nil,
  bgQuad = nil,
  
  create = function(this, init)
    if init.bgImage then
      local bgImageName = init and init.bgImage    
      local bgImage = this.resource:get("image", bgImageName)
      
      this.bgDraw = this.graphics.newImage(bgImage)
      this.bgQuad = this.graphics.newQuad(0, 0, 0, 0, this.bgDraw:getWidth(), this.bgDraw:getHeight())
    end
  end,
  
  drawBg = function(this, data, area, view)
    if data:hide() then return end    
    
    local alpha = data:alpha()
    local bgColor = data:bgColor()
    local bgImage = data:bgImage()
    local bgAlpha = data:bgAlpha()
    
    area = data:bounds(area)
    local x, y, w, h = area.x, area.y, area.w, area.h
    this.graphics.setScissor(area.vx, area.vy, area.vw, area.vh)

    if bgColor then
      this.graphics.setColor(bgColor.r * 255, bgColor.g * 255, bgColor.b * 255, alpha * bgAlpha * 255)
      this.graphics.rectangle('fill', x, y, w, h)
    end
    
    if bgImage then
      this.graphics.setColor(255, 255, 255, alpha * bgAlpha * 255)
      this.bgQuad:setViewport(0, 0, w, h)
      this.graphics.drawq(this.bgDraw, this.bgQuad, x, y)
      
    end
    
    this.graphics.setColor(255, 255, 255, 255)
    this.graphics.setScissor() 
  end,
  
  drawFg = function(this, data, area)
    if data:hide() then return end    

    local color = data:color()
    local bdColor = data:bdColor()
    local alpha = data:alpha()
    
    area = data:bounds(area)
    local x, y, w, h = area.x, area.y, area.w, area.h
    
    this.graphics.setScissor(area.vx, area.vy, area.vw, area.vh)
    this.graphics.setColor(color.r * 255, color.g * 255, color.b * 255, alpha * 255)

    this.doDraw(this, data, x, y, w, h)
    
    if bdColor then
      this.graphics.setColor(bdColor.r * 255, bdColor.g * 255, bdColor.b * 255, alpha * 255)
      this.graphics.rectangle('line', x, y, w, h)
    end
    
    this.graphics.setColor(255, 255, 255, 255)    
    this.graphics.setScissor() 
  end,

  draw = function(this, data, area, view)
    this:drawBg(data, area, view)
    this:drawFg(data, area, view)
  end,
}