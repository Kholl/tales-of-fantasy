--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Math = {
  Abs = math.abs,
  
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
    local ps = {{x = r1.x1, y = r1.y1}, {x = r1.x2, y = r1.y1}, {x = r1.x1, y = r1.y2}, {x = r1.x2, y = r1.y2}}
    
    out = (r1.x1 < r2.x1 and r1.x2 < r2.x1) or (r1.y1 < r2.y1 and r1.y2 < r2.y1) or
          (r1.x1 > r2.x2 and r1.x2 > r2.x2) or (r1.y1 > r2.y2 and r1.y2 > r2.y2)
    return not out
  end
}
