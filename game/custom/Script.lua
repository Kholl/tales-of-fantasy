--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScriptUnused = {
  -- Actions  
  act = function(action) return F{function(actor)
    actor:state(action)
  end}
  end,
}
