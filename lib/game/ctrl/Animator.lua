--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Animator = Class {
  create = function(this, init)
    this.func = init.func or Animator.Linear
    this.prop = init.prop
    this.key = init.key
    
    this.val = {}
    this.val.ini = init.val and init.val.ini or 0
    this.val.fin = init.val and init.val.fin or 100
    
    this.time = {}
    this.time.t = 0
    this.time.fin = init.time and init.time or 1
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, scene, game)
    this.time.t = this.time.t + delta    
    this.time.k = (this.time.t / this.time.fin)
    
    this.prop[this.key] = this.func(this.val.ini, this.val.fin, this.time.k)
    if this.time.t > this.time.fin then scene:kill(this) end
  end,
  
  Linear = function(a, b, k) return a*(1-k) + b*k end,
  Accel = function(a, b, k) return a*(1-(k*k)) + b*k*k end,
  Decel = function(a, b, k) return a*(1-math.sqrt(k)) + b*math.sqrt(k) end,
}