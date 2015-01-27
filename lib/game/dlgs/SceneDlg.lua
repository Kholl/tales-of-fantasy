--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneDlg = Moo.Class {
  rules = nil,
  
  create = function(this, rules)
    this.rules = List(Rule).new()
    Each(rules, function(rule) this.rules:addNew(rule) end)
  end,
  
  update = function(this, context)
    this.rules:each(function(rule) rule:execute(context) end)
  end,
}