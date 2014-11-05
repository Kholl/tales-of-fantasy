--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SpriteData = Class {
  graphics = Dependency("graphics"),
  
  dim = Property("_dim"), -- Dimension
  pad = Property("_pad"), -- Padding

  frame = nil,
  frate = nil,
  nframes = nil,  
  ended = nil,
  
  create = function(this, init)
    this.frame = init and init.frame or 0
    this.frate = init and init.frate or 1
    this.nframes = init and init.nframes or 1
    this:dim(init and init.dim or {w = 0, h = 0})
    this:pad(init and init.pad or {x = 0.5, h = 0.5})
    this.ended = false
  end,
  
  incr = function(this, frame)
    local frate
    if type(this.frate) == "table"
      then frate = this.frate[math.floor(this.frame) +1] or this.frate[1]
      else frate = this.frate
    end
    
    this.frame = this.frame + (frame / frate)
    return this
  end,
  
  loop = function(this)
    this.frame = this.frame % this.nframes
    return this
  end,
  
  limit = function(this)
    if this.frame >= (this.nframes) then this.ended = true end
    
    this.frame = Math.Lim(this.frame, {min = 0, max = this.nframes})
    return this
  end,

  get = function(this)
    return Math.Lim(math.floor(this.frame), {min = 0, max = this.nframes -1})
  end,
  
  set = function(this, val)
    this.frame = Math.Lim(math.floor(val), {min = 0, max = this.nframes -1})
  end,
  
  reset = function(this, val) this.frame, this.ended = 0, false end,
}