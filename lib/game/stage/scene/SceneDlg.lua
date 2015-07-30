--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneDlg = Class {
  rules = nil,
  run = nil,
  
  create = function(this, rules)
    this.rules = rules or {}
    this.run = true
  end,
  
  draw = Nil,
  
  step = function(this, scene, game)
    if not this.run then return end
  
    local rules = this.rules.all or {}
    IndexList.each(rules, function(rule, index) rule(scene, game) end)
    
    local state = scene:state()
    local stateRules = this.rules[state] or {}
    IndexList.select(stateRules, function(rule, index) return rule(scene, game) end)
  end,
  
  update = Nil,
  
  play = function(this) this.run = true end,
  stop = function(this) this.run = false end,
}