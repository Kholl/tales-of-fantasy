--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/Script")

GraphicRules = Class {
  
  rules = nil,
  running = nil,
  
  create = function(this, rules)
    this.rules = rules or {}
    this.running = true
  end,
  
  draw = Nil,
  
  update = function(this, delta, graphic, parent, game)
    if not this.running then return end
    IndexList.each(this.rules, function(rule, index) rule(graphic, parent, game) end)
  end,
  
  run = function(this) this.running = true end,
  stop = function(this) this.running = false end,
}