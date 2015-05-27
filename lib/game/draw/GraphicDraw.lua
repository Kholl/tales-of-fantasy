--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicDraw = Class {
  graphics = Dependency("graphics"),

  draw = function(this, data, parent)
    if data:hidden() then return end    
    local x, y, w, h, b = data:area(parent)
          
    local bgColor = data:bgColor()
    local bgAlpha = data:bgAlpha()
    if bgColor then
      this.graphics.setColor(bgColor.r * 255, bgColor.g * 255, bgColor.b * 255, bgAlpha * 255)
      this.graphics.rectangle('fill', x, y, w, h)
    end
    
    local bdColor = data:bdColor()
    if bdColor then
      this.graphics.setColor(bdColor.r * 255, bdColor.g * 255, bdColor.b * 255, 255)
      this.graphics.rectangle('line', x, y, w, h)
    end
    
    local color = data:color() or {r = 1, g = 1, b = 1}
    local alpha = data:alpha()
    this.graphics.setColor(color.r * 255, color.g * 255, color.b * 255, alpha * 255)
  
    this.doDraw(this, data, x, y, w, h, b)
  
    this.graphics.setColor(255, 255, 255)
  end,
}