--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/List")

KeybDir = Class {
  keyboard = Dependency("keyboard"),  
  keys = nil,
  
  create = function(this, init)
    this.keys = List().new(init or {})
  end,
    
  update = function(this, context)
    local actor = context.actor
    actor.cmd = {idle = true}
    
    this.keys:each(function(cmd, key)
      if this.keyboard.isDown(key) then
        actor.cmd[cmd], actor.cmd.idle = true, false
      end
    end)
  end,
}
