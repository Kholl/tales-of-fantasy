--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorScript = {
  -- Actions  
  act = function(action) return F{function(actor)
    actor:state(action)
  end}
  end,
  
  dir = function(dir) return F{function(actor)
    actor:dir(dir)
  end}
  end,
  
  spd = function(spd) return F{function(actor)
    actor:spd(spd)
  end}
  end,
  
  setExtra = function(key, value) return F{function(actor)
    actor:extra(key, value)
  end}
  end,

  faceTarget = F{function(actor) actor:face() end},
  
  move = function(force, k) return F{function(actor, scene)
    local k = k or {}
    local spd = actor:spd()
    local dir = actor:dir()
    if force.y then spd.y = force.y end
    
    local kx, kz = dir.x, dir.z
    if not (kx == 0) then spd.x, dir.x = kx * (force.x or 0), kx end
    if not (kz == 0) then spd.z, dir.z = kz * (force.z or 0), kz end
    
    actor:spd(XYZ(spd) * XYZ(k))
    
    return true
  end}
  end,
  
  force = function(force) return F{function(actor) actor:force(force) end} end,
  
  -- Triggers
  at = function(start, finish) return F{function(actor, scene, game)
    finish = finish or start + 1 / game.fps
    return scene:time() >= start and scene:time() < finish
  end}
  end,

  isTargetState = function(pattern) return F{function(actor, scene)
    local target = actor:target()
    if not target then return false end
    
    return not (string.match(target:state(), pattern) == nil)
  end}
  end,
  
  isRange = function(k, max, min) return F{function(actor, scene)
    if not actor:target() then return false end
    
    local dist = actor:distout()
    
    local ok = true
    if ok and min then ok = ok and (dist[k] >= min) end
    if ok and max then ok = ok and (dist[k] <= max) end
    
    return ok
  end}
  end,

  isKey = function(key) return F{function(actor, scene, game)
    local player = actor:player()
    return game.control[player] and game.control[player]:isKey(key)
  end}
  end,

  isKeypress = function(key) return F{function(actor, scene, game)
    local player = actor:player()
    return game.control[player]:isKeypress(key)
  end}
  end,
  
  isFrame = function(nframe) return F{function(actor, scene)
    return actor:isStep() and actor:frame() == nframe
  end}
  end,
  
  isFloor = F{function(actor, scene) return scene.phys:isFloor(actor) end},

  isFall = F{function(actor, scene) return actor:spd().y > 0 end},
  isKeyb = F{function(actor, scene) return not (actor:keyb() == false) end},
  isAuto = F{function(actor, scene) return not (actor:auto() == false) end},
  isEnded = F{function(actor, scene) return actor:isEnded() end},
  isTarget = F{function(actor, scene) return not (actor:target() == false) end},  
  
  pick = function(list) return F{function(actor, scene, game)
    return list[math.random(1, #list)](actor, scene, game)
  end}
  end,

  all = function(list) return F{function(actor, scene, game)
    List.each(list, function(rule) rule(actor, scene, game) end)
    return false
  end}
  end,
  
  prob = function(list) return F{function(actor, scene, game)
    local n = math.random(1, 100)
    local func = IndexList.select(list, function(func, value) return n <= value end)
    return func(actor, scene, game)
  end}
  end,
  
  -- Custom extra properties
  extra = function(key) return {
    gt = function(val) return F{function(actor) return actor:extra(key) > val end} end,
    lt = function(val) return F{function(actor) return actor:extra(key) < val end} end,
    eq = function(val) return F{function(actor) return actor:extra(key) == val end} end,     
    set = function(val) return F{function(actor) actor:extra(key, val) end} end,

    inc = function(inc) return F{function(actor)
      local val = actor:extra(key)
      return actor:extra(key, val + inc)
    end}
    end,
    
    dec = function(dec) return F{function(actor)
      local val = actor:extra(key)
      return actor:extra(key, val - dec)
    end}
    end,
  } end,
}
