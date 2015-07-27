--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDlg = Class {
  rules = nil,
  run = nil,
  
  create = function(this, rules)
    this.rules = rules or {}
    this.run = true
  end,
  
  draw = Nil,
  
  step = function(this, actor, scene, game)
    if not this.run then return end
  
    local rules = this.rules.all or {}
    IndexList.each(rules, function(rule, index) rule(actor, scene, game) end)
    
    local state = actor:state()
    local stateRules = this.rules[state] or {}
    IndexList.select(stateRules, function(rule, index) return rule(actor, scene, game) end)
  end,
  
  update = Nil,
  
  play = function(this) this.run = true end,
  stop = function(this) this.run = false end,
}