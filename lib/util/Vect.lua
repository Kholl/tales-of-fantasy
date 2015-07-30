--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/util/List")

Vect = function(coord) return Moo.Operator {
  ["_"] = function(a)
    return Vect(coord)(Moo.List.each(coord, function(v, k) return -a[k] end))
  end,

  ["+"] = function(a, b)
    if type(b) == 'number' 
      then return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 0) + b end))
      else return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 0) + (b[k] or 0) end))
    end
  end,
  
  ["-"] = function(a, b)
    if type(b) == 'number' 
      then return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 0) - b end))
      else return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 0) - (b[k] or 0) end))
    end
  end,
  
  ["*"] = function(a, b)
    if type(b) == 'number' 
      then return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 1) * b end))
      else return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 1) * (b[k] or 1) end))
    end
  end,
  
  ["/"] = function(a, b)
    if type(b) == 'number' 
      then return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 1) / b end))
      else return Vect(coord)(Moo.List.each(coord, function(v, k) return (a[k] or 1) / (b[k] or 1) end))
    end
  end,
}
end

-- Alisases

-- 2D Coordinates
XY = Vect{x = 1, y = 2}
-- 3D Coordinates
XYZ = Vect{x = 1, y = 2, z = 3}
-- Dimension coordinates (width height)
WH = Vect{w = 1, h = 2}
-- Color
RGB = Vect{r = 1, g = 2, b = 3}

if __TEST then
  local a, r = XYZ{x = 1, y = 2, z = 3}, 0
  r = a + a; assert(r.x == 2 and r.y == 4 and r.z == 6)
  r = a - a; assert(r.x == 0 and r.y == 0 and r.z == 0)
  r = a * a; assert(r.x == 1 and r.y == 4 and r.z == 9)
  r = a / a; assert(r.x == 1 and r.y == 1 and r.z == 1)
  r = a + 1; assert(r.x == 2 and r.y == 3 and r.z == 4)
  r = a - 1; assert(r.x == 0 and r.y == 1 and r.z == 2)
  r = a * 1; assert(r.x == 1 and r.y == 2 and r.z == 3)
  r = a / 1; assert(r.x == 1 and r.y == 2 and r.z == 3)
end