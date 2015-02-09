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
    local rules = actor.rules[state] or {}
    local param = actor.param[state]
    Each(rules, function(rule, action)
      local event = rule.event
      local info = rule.info
      if event(actor, scene) then actor:action(action, info) end
    end)
  end,
}