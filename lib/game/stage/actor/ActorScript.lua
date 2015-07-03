--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorScript = {
  -- Actions  
  act = function(action) return F(function(actor, scene)
    actor:state(action)
  end)
  end,
  
  find = F(function(actor, scene)
    local auto = actor:auto()
    local actors = scene:getActors()
    if not auto then return end
    
    actors = List.filter(actors, auto:filter(actor, scene))
    actors = List.sort(actors, auto:eval(actor, scene))
    actor:target(actors[1])
  end),
  
  move = function(force) return F(function(actor, scene)
    local spd = actor:spd()
    local dir = actor:dir()
    if force.y then spd.y = force.y end
    
    local kx, kz
    if actor:auto()
      then kx, kz = actor:auto():direction(actor)
      else kx, kz = dir.x, dir.z
    end
  
    if not (kx == 0) then spd.x, dir.x = kx * (force.x or 0), kx end
    if not (kz == 0) then spd.z, dir.z = kz * (force.z or 0), kz end
    
    actor:spd(spd)
    
    return true
  end)
  end,
  
  hitAll = function(hit) return F(function(actor, scene)
    local hits = scene:getHits(actor)
    List.each(hits, function(other) actor:hit(other, hit) end)
  end)
  end,
  
  -- Triggers
  isTargetHit = function(states) return F(function(actor, scene, target)
    target = target or actor:target()
    if target == false then return false end
    
    states = List.asTable(states or actor:state())
    local select = List.select(states, function(state)
      local f = Math.Sign(actor:dir().x)
      local d = actor:dist(target)
      
      if (f ==  1 and actor:pos().x < target:pos().x) or
         (f == -1 and actor:pos().x > target:pos().x) then
        
        local z = (actor:rad() + target:rad()) * 0.5
        local x = (actor.states[state]:dim().w + target:box().w) * 0.5
        
        return (d.x < x) and (d.z < z)
      end
    end)
  
    return not (select == nil)
  end)
  end,
  
  isRange = function(k, max, min) return F(function(actor, scene)
    local dist = actor:dist()
    local ok = true
    if ok and min then ok = ok and (dist[k] >= min) end
    if ok and max then ok = ok and (dist[k] <= max) end
    return ok
  end)
  end,

  isKey = function(key) return F(function(actor, scene)
    return actor:auto():isKey(key)
  end)
  end,
  
  isFrame = function(nframe) return F(function(actor, scene)
    return actor:curr():isStep() and actor:curr():frame() == nframe
  end)
  end,
      
  isDied = F(function(actor, scene) return actor.info.hp == 0 end),
  isFall = F(function(actor, scene) return actor:spd().y > 0 end),
  isKeyb = F(function(actor, scene) return not (actor:keyb() == false) end),
  isAuto = F(function(actor, scene) return not (actor:auto() == false) end),
  isEnded = F(function(actor, scene) return actor:curr():isEnded() end),
  isTarget = F(function(actor, scene) return not (actor:target() == false) end),  
}
