--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Vect = Moo.Class {
  
  create = function(this, init)
    List.each(init, function(v, k) this[k] = init[k] end)
  end,
  
  eval = function(init, func)
    return Vect.new(List.each(init, func))
  end,
  
  sign = function(a)
    return Vect.eval(a, function(v, k) 
      if a[k] == 0 then return 0 else return a[k] / math.abs(a[k]) end
    end)
  end,
  
  ["_"] = function(a)
    return Vect.eval(a, function(v, k) return -a[k] end)
  end,
  
  ["+"] = function(a, b)
    if type(b) == 'number' 
      then return Vect.eval(a, function(v, k) return a[k] + b end)
      else return Vect.eval(a, function(v, k) return a[k] + b[k] end)
    end
  end,
  
  ["-"] = function(a, b)
    if type(b) == 'number' 
      then return Vect.eval(a, function(v, k) return a[k] - b end)
      else return Vect.eval(a, function(v, k) return a[k] - b[k] end)
    end
  end,
  
  ["*"] = function(a, b)
    if type(b) == 'number' 
      then return Vect.eval(a, function(v, k) return a[k] * b end)
      else return Vect.eval(a, function(v, k) return a[k] * b[k] end)
    end
  end,
  
  ["/"] = function(a, b)
    if type(b) == 'number' 
      then return Vect.eval(a, function(v, k) return a[k] / b end)
      else return Vect.eval(a, function(v, k) return a[k] / b[k] end)
    end
  end,
}

-- Alisases
V = function(init) return Vect.new(init) end

if __TEST then
  local a, r = V{x = 1, y = 2, z = 3}, 0
  r = a + a; assert(r.x == 2 and r.y == 4 and r.z == 6)
  r = a - a; assert(r.x == 0 and r.y == 0 and r.z == 0)
  r = a * a; assert(r.x == 1 and r.y == 4 and r.z == 9)
  r = a / a; assert(r.x == 1 and r.y == 1 and r.z == 1)
  r = a + 1; assert(r.x == 2 and r.y == 3 and r.z == 4)
  r = a - 1; assert(r.x == 0 and r.y == 1 and r.z == 2)
  r = a * 1; assert(r.x == 1 and r.y == 2 and r.z == 3)
  r = a / 1; assert(r.x == 1 and r.y == 2 and r.z == 3)
  
  local b = V{x = 5, y = 0, z = -5}
  r = b:sign(); assert(r.x == 1 and r.y == 0 and r.z == -1)
end