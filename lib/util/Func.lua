--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Func = Moo.Operator {
  -- Function call
  ["()"] = function(list, ...)
    local res = {}
    for key, f in ipairs(list) do res[key] = f(...) end
    return unpack(res)
  end,
  
  -- Function negation
  ["_"] = function(a) return F{function(...) return not a(...) end} end,
  
  -- Function and
  ["^"] = function(a, b) return F{function(...) return a(...) and b(...) end} end,
  
  -- Function or
  ["+"] = function(a, b) return F{function(...) return a(...) or b(...) end} end,

  -- Function then
  ["/"] = function(a, b)
    if type(b) == "table" then b = F(b) end
    return F{function(...) if a(...) then b(...) return true end end}
  end,  
}

-- Alias
F = Func

-- Test suite
if __TEST then
  local a = F{function(a, b) return a > b end}
  local b = F{function(a, b) return a < b end}
  local c = F{function(a, b) return a == b end}
  local d = F{function(a) return a * 2 end}
  local e = F{function(a) return a + 2 end}
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
  assert(((a + b) / d)(5, 3) == true, 10)
  assert((a / d)(5, 3) == true, 10)
  assert((-a / d)(5, 3) == nil)
end