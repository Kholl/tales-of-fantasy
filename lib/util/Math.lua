--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Math = {
  MAX = 2^32,
  
  Abs = math.abs,
  Rand = math.random,
  
  Sign = function(val)
    if val == 0 then return 0
    elseif type(val) == "number" then return val / math.abs(val)
    elseif type(val) == "table" then return Moo.List.each(val, Math.Sign)
    else error("Value is not number nor table")
    end
  end,
  
  Lim = function(val, lim)
    if type(val) == "number" then
      if lim.min and lim.max then return math.min(math.max(lim.min, val), lim.max)
        elseif lim.max then return math.min(val, lim.max)
        elseif lim.min then return math.max(val, lim.min)
        else return val
      end
    elseif type(val) == "table" then return Moo.List.each(val, Math.Lim)
    else error("Value is not number nor table")
    end
  end,
  
  Pick = function(list) return list[math.random(1, #list)] end,
  Ratio = function(a, b) return a / (a + b) end,
  Linear = function(a, b, k) return (a * k) + (b * (1 - k)) end,
}
