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
    
    List.each(stateRules, function(rule, action)
      if rule(actor, scene)
        and actor.states[action]
        and not (actor:state() == action) then
  
        actor:start(action)
      end
    end)
  end,
}