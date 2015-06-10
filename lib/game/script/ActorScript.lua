--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorScript = {
  -- Actions  
  act = function(action) return F(function(actor, scene)
    actor:start(action)
  end)
  end,
  
  find = F(function(actor, scene)
    local auto = actor:auto()
    local actors = scene:getActors()
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
  isHit = function(state) return F(function(actor, scene, target)
    target = target or actor:target()
    state = state or actor:state() 
    local f = Math.Sign(actor:dir().x)
    local d = actor:dist(target)
    if (f ==  1 and actor:pos().x < target:pos().x) or
       (f == -1 and actor:pos().x > target:pos().x) then
      
      local x, z = (actor.states[state]:dim().w * 0.5) + target:rad(), target:rad()
      return d.x < x and d.z < z
    end
    
    return false
  end)
  end,
  
  isRange = function(k, max, min) return F(function(actor, scene)
    local min = min or 0
    local dist = actor:dist()
    return (dist[k] >= min) and (dist[k] <= max) 
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
  isTarget = F(function(actor, scene) return not (actor:auto() == false or actor:target() == false) end),  
}
