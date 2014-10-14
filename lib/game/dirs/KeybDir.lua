--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

KeybDir = Class {
  keyboard = Dependency("keyboard"),
  
  keys = nil,
  input = nil,
  
  create = function(this, init)
    this.keys = init or {}
  end,
    
  update = function(this, context)
    local actor = context.actor
    actor.cmd = {idle = true}
    
    Each(this.keys, function(key, cmd)
      if this.keyboard.isDown(key) then
        actor.cmd[cmd], actor.cmd.idle = true, false
      end
    end)
  end,
}
