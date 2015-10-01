--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicData = Class {
  pos = Property("_pos", {use = XYZ}), -- Position
  dim = Property("_dim", {use = WH}), -- Dimension
  dir = Property("_dir", {use = XY}), -- Direction
  hide = Property("_hide"), -- Hide
  time = Property("_time"), -- Local time
  tmul = Property("_tmul"), -- Local time multiplier
  color = Property("_color"), -- Foreground color
  alpha = Property("_alpha"), -- Alpha
  extra = Property("_extra"), -- Extras
  bgColor = Property("_bgColor"), -- Background color
  bgImage = Property("_bgImage"), -- Background image
  bgAlpha = Property("_bgAlpha"), -- Background alpha
  bdColor = Property("_bdColor"), -- Border color
  
  create = function(this, init)
    this:dim(init and init.dim or {w = 1, h = 1})
    this:pos(init and init.pos or {x = 0, y = 0})
    this:dir(init and init.dir or {x = 1, y = 1})
    this:time(init and init.time or 0)
    this:hide(init and init.hide or false)
    this:color(init and init.color or {r = 1, g = 1, b = 1})
    this:alpha(init and init.alpha or 1)
    this:extra(init and init.extra or {})
    this:bgColor(init and init.bgColor or false)
    this:bgImage(init and init.bgImage or false)
    this:bgAlpha(init and init.bgAlpha or 1)
    this:bdColor(init and init.bdColor or false)
  end,
  
  update = function(this, delta, object, game)
    this._time = math.max(0, this._time + delta)
  end,
  
  bounds = function(this, area)    
    local pos, dim = this:pos(), this:dim()
    local x, y = pos.x, pos.y
    local w, h = dim.w, dim.h
    local px, py = area.x, area.y
    local pw, ph = area.w, area.h
    
    if w >= -1 and w <= 1 then w = w * pw end
    if h >= -1 and h <= 1 then h = h * ph end

    if x < 0 then x = x + pw - w
    elseif x <= 1 then x = (pw - w) * x
    end
    
    if y < 0 then y = y + ph - h
    elseif y <= 1 then y = (ph - h) * y
    end
  
    return {
      x = px + x, y = py + y, w = w, h = h,
      vx = math.max(px, px + x), vy = math.max(py, py + y), vw = math.min(pw, w), vh = math.min(ph, h)}  
  end,
}