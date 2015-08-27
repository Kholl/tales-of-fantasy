--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/Script")

SceneRules = Class {
  rules = nil,
  running = nil,
  
  create = function(this, rules)
    this.rules = rules or {}
    this.running = true
  end,
  
  draw = Nil,
  
  step = function(this, scene, game)
    if not this.running then return end
  
    local rules = this.rules[1] or {}
    IndexList.each(rules, function(rule, index) rule(scene, game) end)
    
    local state = scene:state()
    local stateRules = this.rules[state] or {}
    IndexList.select(stateRules, function(rule, index) return rule(scene, game) end)
  end,
  
  update = Nil,
  
  run = function(this) this.running = true end,
  stop = function(this) this.running = false end,
}