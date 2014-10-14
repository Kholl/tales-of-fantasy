--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Sprite")

State = Class {
  state = Property("_state"),
  draw = nil,
  states = nil,
  
  create = function(this, init)
    this._state = init and init.state
    
    this.states = {}
    Each(init and init.states, function(key, state)
      this.states[key] = Sprite.new(state)
    end)
  end,
  
  draw = function(this, data, scene)
    this:curr():draw(data, scene)
  end,
  
  update = function(this, scene)
    this:curr():update(scene)
  end,
    
  curr = function(this) return this.states[this:state()] end,

  start = function(this, state)
    this:state(state)
    this:curr():reset()
  end,
}
