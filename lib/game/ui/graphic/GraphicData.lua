--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicData = Class {
  pos = Property("_pos", {use = XYZ}), -- Position
  dim = Property("_dim", {use = WH}), -- Dimension
  dir = Property("_dir", {use = XY}), -- Direction
  view = Property("_view"), -- Viewport
  color = Property("_color"), -- Foreground color
  alpha = Property("_alpha"), -- Alpha
  bgColor = Property("_bgColor"), -- Background color
  bgImage = Property("_bgImage"), -- Background image
  bgAlpha = Property("_bgAlpha"), -- Background alpha
  bdColor = Property("_bdColor"), -- Border color
  hide = Property("_hide"), -- Hide
  time = Property("_time"), -- Local time
  tmul = Property("_tmul"), -- Local time multiplier
  
  create = function(this, init)
    this:dim(init and init.dim or {w = 1, h = 1})
    this:pos(init and init.pos or {x = 0, y = 0})
    this:dir(init and init.dir or {x = 1, y = 1})
    this:view(init and init.view or {})
    this:color(init and init.color or {r = 1, g = 1, b = 1})
    this:alpha(init and init.alpha or 1)
    this:bgColor(init and init.bgColor or false)
    this:bgImage(init and init.bgImage or false)
    this:bgAlpha(init and init.bgAlpha or 1)
    this:bdColor(init and init.bdColor or false)
    this:hide(init and init.hide or false)
  
    this:time(0)
    this:tmul(1)
    if init.stop then this:tmul(0) end
  end,
  
  update = function(this, delta, object, game)
    this._time = math.max(0, this._time + (this._tmul * delta))
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
  
    local view = this:view()
    local area = {x = px + x, y = py + y, w = w, h = h}
    
    view = {
      x = view.x or math.max(px, area.x),
      y = view.y or math.max(py, area.y),
      w = view.w or math.min(pw, area.w),
      h = view.h or math.min(ph, area.h)}
    
    return area, view
  end,
}