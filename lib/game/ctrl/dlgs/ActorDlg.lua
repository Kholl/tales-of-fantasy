--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDlg = Moo.Class {
  rules = nil,
  
  create = function(this, init)
    this.rules = init.rules or {}
  end,
  
  update = function(this, actor, scene)
    local state = actor:state()
    local rules = this.rules[state] or {}
    List.each(rules, function(rule, action)
      if rule(actor, scene)
        and actor.states[action]
        and not (actor:state() == action) then
        
        actor:start(action)
      end
    end)
  end,
}