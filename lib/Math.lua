--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Math = {
  MAX = 2^32,
  
  Abs = math.abs,
  Rand = math.random,
  
  Sign = function(val)
    if val == 0 then return 0 end
    return val / math.abs(val)
  end,
  
  Lim = function(val, lim)
    if lim.min and lim.max then return math.min(math.max(lim.min, val), lim.max)
      elseif lim.max then return math.min(val, lim.max)
      elseif lim.min then return math.max(val, lim.min)
      else return val
    end
  end,
  
  Dist = function(a, b) return {x = a.x - b.x, y = a.y - b.y, z = a.z - b.z} end,
    
  Isect = function(box1, box2)
    local r1 = {x1 = box1.x, y1 = box1.y, x2 = box1.x + box1.w, y2 = box1.y + box1.h}
    local r2 = {x1 = box2.x, y1 = box2.y, x2 = box2.x + box2.w, y2 = box2.y + box2.h}
    
    out = (r1.x1 < r2.x1 and r1.x2 < r2.x1) or (r1.y1 < r2.y1 and r1.y2 < r2.y1) or
          (r1.x1 > r2.x2 and r1.x2 > r2.x2) or (r1.y1 > r2.y2 and r1.y2 > r2.y2)
    return not out
  end,
  
  InLim = function(dist, lim)
    return 
      (dist >= -(lim and lim.max or Math.MAX) and dist <= -(lim and lim.min or 0)) or
      (dist <=  (lim and lim.max or Math.MAX) and dist >=  (lim and lim.min or 0))
  end,
  
  InLimOf = function(keys)
    local keylist = List().new(keys)
    return function(dist, lim)
      return keylist:all(function(key)
        return Math.InLim(dist[key], lim[key])
      end)
    end
  end,
  
  Pick = function(list) return list[math.random(1, #list)] end,
}
