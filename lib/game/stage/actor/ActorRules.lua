--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorRules = Class {
  
  rules = nil,
  running = nil,
  
  create = function(this, rules)
    this.rules = rules or {}
    this.running = true
  end,
  
  draw = Nil,
  
  step = function(this, actor, scene, game)
    if not this.running then return end
  
    local rules = this.rules[1] or {}
    IndexList.each(rules, function(rule, index) rule(actor, scene, game) end)
    
    local state = actor:state()
    local stateRules = this.rules[state] or {}
    IndexList.select(stateRules, function(rule, index) return rule(actor, scene, game) end)
  end,
  
  update = Nil,
  
  run = function(this) this.running = true end,
  stop = function(this) this.running = false end,
    
  add = function(this, rules)
    List.each(rules, function(rules, state)
      if this.rules[state] == nil then this.rules[state] = {} end
      IndexList.each(rules, function(rule) table.insert(this.rules[state], 1, rule) end)
    end)
  
    return this
  end
}