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
    local p1 = {x1 = box1.x, y1 = box1.y, x2 = box1.x + box1.w, y2 = box1.y + box1.h}
    local p2 = {x1 = box2.x, y1 = box2.y, x2 = box2.x + box2.w, y2 = box2.y + box2.h}
    local ps = {{x = p1.x1, y = p1.y1}, {x = p1.x2, y = p1.y1}, {x = p1.x1, y = p1.y2}, {x = p1.x2, y = p1.y2}}
    
    isect = (p1.x1 >= p2.x1 and p1.x1 <= p2.x2 and p1.y1 >= p2.y1 and p1.y1 <= p2.y2)
    isect = isect or (p1.x2 >= p2.x1 and p1.x2 <= p2.x2 and p1.y1 >= p2.y1 and p1.y1 <= p2.y2)
    isect = isect or (p1.x1 >= p2.x1 and p1.x1 <= p2.x2 and p1.y2 >= p2.y1 and p1.y2 <= p2.y2)
    isect = isect or (p1.x2 >= p2.x2 and p1.x2 <= p2.x2 and p1.y2 >= p2.y1 and p1.y2 <= p2.y2)
    isect = isect or (p1.x1 <  p2.x1 and p1.x2 >  p2.x2 and p1.y1 >= p2.y1 and p1.y2 <= p2.y2)
    isect = isect or (p1.x1 >= p2.x1 and p1.x2 <= p2.x2 and p1.y1 <  p2.y1 and p1.y2 >  p2.y2)
    
    return isect
  end,
}
