--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Animator = Class {
  
  func = nil,
  prop = nil,
  key = nil,
  v = nil,
  v0 = nil,
  v1 = nil,
  k = nil,
  t0 = nil,
  t1 = nil,
          
  create = function(this, init)
    this.func = init.func or Animator.Linear
    this.prop = init.prop
    this.key = init.key or false
    
    this.v0, this.v1 = init.v[1], init.v[2]
    this.t0, this.t1 = init.t[1], init.t[2]
    
    this.t = 0
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, group, game)
    this.t = this.t + delta    
    this.k = math.min(1, math.max(0, ((this.t - this.t0) / (this.t1 - this.t0))))
    local value = this.func(this.v0, this.v1, this.k)
    
    local data = group.data
    local property = data[this.prop](data)
    if this.key then property[this.key] = value else property = value end
    
    data[this.prop](data, property)
    
    if this.t > this.t1 then group:rem(this) end
  end,
  
  Linear = function(a, b, k) return a*(1-k) + b*k end,
  Accel = function(a, b, k) return a*(1-(k*k)) + b*k*k end,
  Decel = function(a, b, k) return a*(1-math.sqrt(k)) + b*math.sqrt(k) end,
}