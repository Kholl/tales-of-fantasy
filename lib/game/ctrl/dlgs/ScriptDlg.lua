--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScriptDlg = Moo.Class {
  ruleset = false,
  state = nil,
  script = nil,
  
  create = function(this, init)
    this.script = init.script or {}
    this.state = init.state or "start"
  end,
  
  update = function(this, delta, actor, scene, game)
    local command = this.script[this.state] or {}
    local state = command(actor)
    if state then this.state = state end
  end,
  
  step = Nil, -- Temporary due to camera adjustments  
  
  filter = function(this, actor, scene) return function(other)
    return false
  end
  end,
  
  eval = function(this, actor, scene) return function(other)
    return false
  end
  end,
    
  direction = function(this, actor)
    local dir = actor:dir()
    return dir.x, dir.z
  end,
}