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
    
    if not init.v then init.v = {0, 1} end
    if not init.t then init.t = {0, 1} end
    
    this.v0, this.v1 = init.v[1], init.v[2]
    this.t0, this.t1 = init.t[1], init.t[2]
    
    this.t = 0
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, object, game)
    local t = object:time()
    if t > this.t1 then return end
    
    local k = math.min(1, math.max(0, ((t - this.t0) / (this.t1 - this.t0))))
    local v = this.func(this.v0, this.v1, k)
    
    local data = object.data
    local property = data[this.prop](data)
    if type(property) == 'table' then property[this.key] = v else property = v end
    
    data[this.prop](data, property)
  end,
  
  reset = function(this) this.t = this.t0 end,
  finish = function(this) this.t = this.t1 end,
  
  Linear = function(a, b, k) return a*(1-k) + b*k end,
  Accel = function(a, b, k) return a*(1-(k*k)) + b*k*k end,
  Decel = function(a, b, k) return a*(1-math.sqrt(k)) + b*math.sqrt(k) end,
}