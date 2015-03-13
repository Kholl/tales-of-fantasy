--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Vect = function(cord) return Moo.Class {
  
  create = function(this, init)
    List.each(cord, function(k, i)
        this[k] = init[i]
        end)
  end,
  
  ["_"] = function(a) return Vect(cord).new(List.each(cord, function(k) return -a[k] end)) end,
  ["+"] = function(a, b) return Vect(cord).new(List.each(cord, function(k) return a[k] + b[k] end)) end,
  ["-"] = function(a, b) return Vect(cord).new(List.each(cord, function(k) return a[k] - b[k] end)) end,
  ["*"] = function(a, b) return Vect(cord).new(List.each(cord, function(k) return a[k] * b[k] end)) end,
  ["/"] = function(a, b) return Vect(cord).new(List.each(cord, function(k) return a[k] / b[k] end)) end,
}
end