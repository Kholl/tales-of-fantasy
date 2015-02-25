--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Func = Moo.Class {
  func = nil,
  
  create = function(this, func) this.func = func end,
  
  ["()"] = function(this, ...) return this.func(...) end,
  ["^"]  = function(a, b) return Func.new(function(...) return a(...) and b(...) end) end,
  ["+"]  = function(a, b) return Func.new(function(...) return a(...) or b(...) end) end,
  ["_"] = function(a) return Func.new(function(...) return not a(...) end) end,
  [".."] = function(a, b) return Func.new(function(...) return a(b(...)) end) end,
  ["/"] = function(a, b) return Func.new(function(...) if a(...) then return b(...) end end) end,
}

-- Alias
F = function(func) return Func.new(func) end

local a = F(function(a, b) return a > b end)
local b = F(function(a, b) return a < b end)
local c = F(function(a, b) return a == b end)
local d = F(function(a) return a * 2 end)
assert(a(5, 3) == true)
assert(b(5, 3) == false)
assert(c(5, 3) == false)
assert((a ^ b)(5, 3) == false)
assert((a ^ b ^ c)(5, 3) == false)
assert((a + b)(5, 3) == true)
assert((a + b)(4, 4) == false)
assert((a + b + c)(5, 3) == true)
assert((-a)(5, 3) == false)
assert((-b)(5, 3) == true)
assert((-c)(5, 3) == true)
assert(d(5) == 10)
assert((d..d)(5) == 20)
assert((a / d)(5, 3) == 10)
assert((-a / d)(5, 3) == nil)
os.exit()