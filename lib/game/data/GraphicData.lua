--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicData = Class {
  pos = Property("_pos"), -- Position
  dim = Property("_dim"), -- Dimension
  align = Property("_align"), -- Alignment
  color = Property("_color"), -- Foreground color
  alpha = Property("_alpha"), -- Alpha
  bgColor = Property("_bgColor"), -- Background color
  bgImage = Property("_bgImage"), -- Background image
  bgAlpha = Property("_bgAlpha"), -- Background alpha
  bdColor = Property("_bdColor"), -- Border color
  hidden = Property("_hidden"), -- Hidden
  time = Property("_time"), -- Local time
  
  create = function(this, init)
    this:dim(init and init.dim or {w = 1, h = 1})
    this:pos(init and init.pos or {x = 0, y = 0})
    this:align(init and init.align or {x = nil, y = nil})
    this:color(init and init.color or {r = 1, g = 1, b = 1})
    this:alpha(init and init.alpha or 1)
    this:bgColor(init and init.bgColor or false)
    this:bgImage(init and init.bgImage or false)
    this:bgAlpha(init and init.bgAlpha or 1)
    this:bdColor(init and init.bdColor or false)
    this:hidden(init and init.hidden or false)
  
    this:time(0)
  end,
  
  update = function(this, delta, object, game)
    this._time = this._time + delta
  end,
  
  area = function(this, parent)
    local align = this:align()
    local pos, dim = this:pos(), this:dim()
    local x, y = pos.x, pos.y
    local w, h = dim.w, dim.h
    local px, py = parent.x, parent.y
    local pw, ph = parent.w, parent.h

    if not (x == nil) and (x < 0) then x = x + pw - w end
    if not (y == nil) and (y < 0) then y = y + ph - h end
    
    if w >= -1 and w <= 1 then w = w * pw end
    if h >= -1 and h <= 1 then h = h * ph end
    
    if not (align.x == nil) then x = (pw - w) * align.x end
    if not (align.y == nil) then y = (ph - h) * align.y end
    
    return {
      x = px + x, y = py + y, w = w, h = h,
      vx = math.max(px + x, px), vy = math.max(py + y, py), vw = math.min(w, pw), vh = math.min(h, ph)}
  end,
}