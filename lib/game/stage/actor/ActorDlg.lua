--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDlg = Moo.Class {
  rules = nil,
  keybrules = nil,
  autorules = nil,
  
  create = function(this, init)
    this.rules = init.rules or {}
    this.keybrules = init.keybrules or {}
    this.autorules = init.autorules or {}
  end,
  
  step = function(this, actor, scene, game)
    this:execute(actor, scene, game, this.rules)
    
    local ruleset = actor:auto() and actor:auto().ruleset
    if ruleset and this[ruleset] then this:execute(actor, scene, game, this[ruleset]) end
  end,
  
  update = Nil,
  
  execute = function(this, actor, scene, game, rules)    
    local state = actor:state()
    local stateRules = rules[state] or {}
    local action = List.select(stateRules, function(rule, action)
      return rule(actor, scene)
    end)

    if action and actor.states[action] then actor:state(action) end
  end,
}