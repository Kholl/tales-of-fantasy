--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDir = Moo.Class {
  stateRules = nil,
  
  create = function(this, stateRules)
    this.stateRules = {}
    
    Each(stateRules, function(state, rules)
        this.stateRules[state] = List(Rule).new()
        Each(rules, function(i, rule) this.stateRules[state]:addNew(rule) end)
    end)
  end,
  
  update = function(this, context)
    local state = context.actor:state()
    local stateRules = this.stateRules[state] or Nil
    
    stateRules:each(function(i, rule) rule:execute(context) end)
  end,
}