--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Animator = Class {
  
  func = nil,
  prop = nil,
  key = nil,
  val = nil,
  time = nil,
          
  create = function(this, init)
    this.func = init.func or Animator.Linear
    this.prop = init.prop
    this.key = init.key
    
    this.val = {}
    this.val.ini = init.from or 0
    this.val.fin = init.to or 100
    
    this.time = {}
    this.time.t = 0
    this.time.ini = init.at or 0
    this.time.fin = init.time or 1
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, group, game)
    this.time.t = this.time.t + delta    
    this.time.k = math.max(0, ((this.time.t - this.time.ini) / this.time.fin))
    local value = this.func(this.val.ini, this.val.fin, this.time.k)
    
    local property = group[this.prop](group)
    if this.key then property[this.key] = value else property = value end
    
    group[this.prop](group, property)
    
    if this.time.t > this.time.fin then group:rem(this) end
  end,
  
  Linear = function(a, b, k) return a*(1-k) + b*k end,
  Accel = function(a, b, k) return a*(1-(k*k)) + b*k*k end,
  Decel = function(a, b, k) return a*(1-math.sqrt(k)) + b*math.sqrt(k) end,
}