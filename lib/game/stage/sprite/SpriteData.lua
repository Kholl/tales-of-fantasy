--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SpriteData = Class {
  graphics = Dependency("graphics"),
  
  box = Property("_box"), -- Hitbox
  rad = Property("_rad"), -- Radius
  dim = Property("_dim"), -- Dimension
  pad = Property("_pad"), -- Padding
  time = Property("_time"), -- Time
  frame = Property("_frame"), -- Frame
  isStep = Property("_isStep"),
  isEnded = Property("_isEnded"),

  _frate = nil,
  _nframes = nil,  
  
  create = function(this, init)
    this._isStep = false
    this._isEnded = false
    this._frate = init and init.frate or 0
    this._nframes = init and init.nframes or 1
    
    this:box(init and init.box or {w = 0, h = 0})
    this:rad(init and init.rad or 0)
    this:dim(init and init.dim or {w = 0, h = 0})
    this:pad(init and init.pad or {x = 0.5, h = 0.5})
    this:time(init and init.time or 0)
    this:frame(init and init.frame or 0)
  end,
  
  incr = function(this)
    local frate
    if type(this._frate) == "table"
      then frate = this._frate[math.floor(this._frame) +1] or this._frate[1]
      else frate = this._frate
    end
    
    local pframe = this._frame
    this._frame = this._frame + (1 / frate)
    this._isStep = not (math.floor(pframe) == math.floor(this._frame))
    
    return this
  end,
  
  loop = function(this)
    this._frame = this._frame % this._nframes
    return this
  end,
  
  limit = function(this)
    if this._frame >= this._nframes then this._isEnded = true end
    this._frame = Math.Lim(this._frame, {min = 0, max = this._nframes})
    return this
  end,

  get = function(this)
    return Math.Lim(math.floor(this._frame), {min = 0, max = this._nframes -1})
  end,
  
  set = function(this, val)
    this._frame = Math.Lim(math.floor(val), {min = 0, max = this._nframes -1})
  end,
  
  reset = function(this, val)
    this._time = 0
    this._frame = 0
    this._isEnded = false
  end,
}