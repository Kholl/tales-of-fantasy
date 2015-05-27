--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicData = Class {
  pos = Property("_pos"), -- Position
  dim = Property("_dim"), -- Dimension
  bdColor = Property("_bdColor"), -- Border color
  color = Property("_color"), -- Foreground color
  alpha = Property("_alpha"), -- Alpha
  bgColor = Property("_bgColor"), -- Background color
  bgAlpha = Property("_bgAlpha"), -- Background alpha
  hidden = Property("_hidden"), -- Hidden
  
  create = function(this, init)
    this:dim(init and init.dim or {w = 1, h = 1})
    this:pos(init and init.pos or {x = 0, y = 0})
    this:bdColor(init and init.bdColor or false)
    this:color(init and init.color or false)
    this:alpha(init and init.alpha or 1)
    this:bgColor(init and init.bgColor or false)
    this:bgAlpha(init and init.bgAlpha or 1)
    this:hidden(init and init.hidden or false)
  end,
  
  area = function(this, parent)
    local pos, dim, pdim = this:pos(), this:dim(), parent:dim()
    local x, y = pos.x, pos.y
    local w, h = dim.w, dim.h
    if x > 0 and x <= 1 then x = x * pdim.w end
    if y > 0 and y <= 1 then y = y * pdim.h end
    if w > 0 and w <= 1 then w = w * pdim.w end
    if h > 0 and h <= 1 then h = h * pdim.h end

    return x, y, w, h
  end,
}