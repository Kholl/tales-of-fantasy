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
 
    if rules.all then
      Each(rules.all, function(rule, action)
        rule(actor, action)
      end)
    end
    
    Each(rules, function(rule, action)
      rule(actor, action)
    end)
  end,
}