--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Group = Moo.Operator {
  -- Function then
  ["?"] = function(a, b) return F{function(...) if a(...) then return true, b(...) end end} end,
}

-- Test suite
if __TEST then
  local a = F{function(a, b) return a > b end}
  local b = F{function(a, b) return a < b end}
  local c = F{function(a, b) return a == b end}
  local d = F{function(a) return a * 2 end}
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
  assert(((a + b) / d)(5, 3) == true, 10)
  assert((a / d)(5, 3) == true, 10)
  assert((-a / d)(5, 3) == nil)
end