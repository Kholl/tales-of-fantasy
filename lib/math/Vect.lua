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

-- Alias
WH = function(init) return Vect{"w", "h"}.new(init) end
XY = function(init) return Vect{"x", "y"}.new(init) end
XYZ = function(init) return Vect{"x", "y", "z"}.new(init) end
RGB = function(init) return Vect{"r", "g", "b"}.new(init) end

-- Test suite
if __TEST then
  local v = XYZ{1, 2, 3}
  local a = v + v
  local b = v - v
  local c = v * v
  local d = v / v
  assert(a.x == 2 and a.y == 4 and a.z == 6)
  assert(b.x == 0 and b.y == 0 and b.z == 0)
  assert(c.x == 1 and c.y == 4 and c.z == 9)
  assert(d.x == 1 and d.y == 1 and d.z == 1)
end