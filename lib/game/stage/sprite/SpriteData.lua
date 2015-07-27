--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SpriteData = Class {
  graphics = Dependency("graphics"),
  
  box = Property("_box"), -- Hitbox
  dim = Property("_dim"), -- Dimension
  pad = Property("_pad"), -- Padding
  anim = Property("_anim"), -- Animation
  
  _frate = nil,
  _frame = nil,
  _nframes = nil,  
  _isStep = nil,
  _isEnded = nil,
  
  create = function(this, init)
    this._isStep, this._isEnded = false, false
    
    this._anim = init and init.anim or "idle"
    this._frate = init and init.frate or 0
    this._frame = init and init.frame or 0
    this._nframes = init and init.nframes or 1
    
    this:box(init and init.box or {w = 0, h = 0})
    this:dim(init and init.dim or {w = 0, h = 0})
    this:pad(init and init.pad or {x = 0.5, h = 0.5})
  end,
    
  step = function(this, actor, scene, game)
    if type(this._anim) == "string" then this[this._anim](this, actor, scene, game)
    elseif type(this._anim) == "function" then this:frame(this._anim(this, actor, scene, game))
    end
  end,
  
  update = Nil,
  
  idle = function(this, actor, scene, game) end,
  play = function(this, actor, scene, game) this:delta(1):lim() end,
  loop = function(this, actor, scene, game) this:delta(1):mod() end,
  looprev = function(this, actor, scene, game) this:delta(-1):mod() end,

  delta = function(this, delta)
    local frate
    if type(this._frate) == "table"
      then frate = this._frate[math.floor(this._frame) + delta] or this._frate[1]
      else frate = this._frate
    end
    
    local pframe = this._frame
    this._frame = this._frame + (delta / frate)
    this._isStep = not (math.floor(pframe) == math.floor(this._frame))
    
    return this
  end,
  
  mod = function(this)
    this._frame = this._frame % this._nframes
    return this
  end,
  
  lim = function(this)
    if this._anim == "playrev" or this._anim == "looprev"
      then this._isEnded = (this._frame < 0)
      else this._isEnded = (this._frame > this._nframes)
    end
    
    this._frame = Math.Lim(this._frame, {min = 0, max = this._nframes})
    return this
  end,

  frame = function(this, val)
    if val == nil then
      return Math.Lim(math.floor(this._frame), {min = 0, max = this._nframes -1})
    end
    
    this._isEnded = (this._frame > this._nframes)
    this._frame = Math.Lim(math.floor(val), {min = 0, max = this._nframes -1})
  end,
  
  reset = function(this)
    this._isEnded = false
    
    if this._anim == "playrev" or this._anim == "looprev"
      then this._frame = this._nframes
      else this._frame = 0
    end
  end,
  
  isStep = function(this) return this._isStep end,
  isEnded = function(this) return this._isEnded end,
}