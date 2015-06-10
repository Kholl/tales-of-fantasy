--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/sprite/Sprite")

State = Class {
  state = Property("_state"),
  
  default = nil,
  states = nil,
  draw = nil,
  
  create = function(this, init)
    this._state = init and init.state
    this.default = init and init.state
    
    this.states = {}
    List.each(init and init.states, function(state, key)
      this.states[key] = Sprite.new{
        res = state.res,
        rad = state.rad or init.rad,
        box = state.box or init.box,
        dim = state.dim or init.dim,
        pad = state.pad or init.pad,
        pmap = state.pmap or init.pmap,
        anim = state.anim,
        frate = state.frate,
        nframes = state.nframes,
      }
    end)
  end,
  
  draw = function(this, data, scene)
    this:curr():draw(data, scene)
  end,
  
  step = function(this, scene, game)
    this:curr():step(this, scene, game)
  end,
  
  update = function(this, delta, scene, game)
    this:curr():update(delta, this, scene, game)
  end,
    
  curr = function(this) return this.states[this:state()] end,

  start = function(this, state)
    this:state(state)
    this:curr():reset()
  end,
  
  reset = function(this) this:start(this.default) end,
}
