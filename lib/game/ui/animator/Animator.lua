--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Animator = Class {
  
  len = Property("_len"),
  
  anim = nil,
  prop = nil,
  time = nil,
  key = nil,
  val = nil,
  running = nil,
          
  create = function(this, init)
    this:len(init.len or 1)
    
    this.anim = init.anim or "Linear"
    this.prop = init.prop
    this.time = init.time or 0
    this.key = init.key or false
    this.val = init.val or {0, 1}
    this.running = false    
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, object, game)    
    if not this.running then return end
    
    this.time = math.min(this.time + delta, this._len)
    if this.time == this._len then this.running = false end
        
    local k = this.time / this._len
    local v = this[this.anim](this.val[1], this.val[2], k)
    
    local data = object.data
    local property = data[this.prop](data)
    
    if type(property) == 'table' and type(this.key) == 'table' then
      List.each(this.key, function(key) property[key] = v end)
    elseif type(property) == 'table' and type(this.key) == 'string' then
      property[this.key] = v
    else
      property = v
    end
    
    data[this.prop](data, property)
  end,
  
--  started = function(this) return this.time > this.t0 end,
--  ended = function(this) return this.time >= this.t1 end,
    
--  playTo = function(this, t1) this:play(t1 - this.d, t1) end,
--  play = function(this, t0, t1) this.t0, this.t1, this.stop = t0, t1 or (t0 + this.d), false end,
--  dur = function(this, d) this.d = d end,

  run = function(this) this.time, this.running = 0, true end,
  stop = function(this) this.running = false end,
  
  Linear = function(a, b, k) return a*(1-k) + b*k end,
  Accel = function(a, b, k) return a*(1-(k*k)) + b*k*k end,
  Decel = function(a, b, k) return a*(1-math.sqrt(k)) + b*math.sqrt(k) end,
}