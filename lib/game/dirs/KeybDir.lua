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
    
    if not actor.cmd.dur then actor.cmd.dur = {idle = 0} end
    
    pre = actor.cmd.pre
    if not actor.cmd.idle then pre = Copy(actor.cmd) end
      
    actor.cmd = {idle = true, pre = pre, dur = {idle = actor.cmd.dur.idle +1}}
    
    this.keys:each(function(cmd, key)
      if this.keyboard.isDown(key) then
        if not actor.cmd.dur[cmd] then actor.cmd.dur[cmd] = 0 end
        actor.cmd.dur[cmd] = actor.cmd.dur[cmd] +1
        actor.cmd.dur.idle = 0
        actor.cmd[cmd] = true
        actor.cmd.idle = false
      end
    end)
  end,
}
