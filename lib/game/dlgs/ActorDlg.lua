--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDlg = Moo.Class {
  stateRules = nil,
  
  create = function(this, stateRules)
    this.stateRules = {}
    
    Each(stateRules, function(rules, state)
        this.stateRules[state] = List(Rule).new()
        Each(rules, function(rule) this.stateRules[state]:addNew(rule) end)
    end)
  end,
  
  update = function(this, context)
    local state = context.actor:state()
    local stateRules = this.stateRules[state] or Nil
 
    if this.stateRules.all then
      this.stateRules.all:each(function(rule) rule:execute(context) end)
    end
    
    stateRules:each(function(rule) rule:execute(context) end)
  end,
}