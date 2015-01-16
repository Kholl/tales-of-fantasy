--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

RuleDlg = Moo.Class {
  rules = nil,
  
  create = function(this, rules)
    this.rules = List(Rule).new()
    Each(rules, function(i, rule) this.rules:addNew(rule) end)
  end,
  
  update = function(this, context)
    this.rules:each(function(i, rule) rule:execute(context) end)
  end,
}