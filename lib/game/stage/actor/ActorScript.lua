--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorScript = {
  -- Actions  
  act = function(action) return F(function(actor)
    actor:state(action)
  end)
  end,
  
  set = function(property, value) return F(function(actor)
    actor[property](actor, value)
  end)
  end,

  faceTarget = F(function(actor) actor:face() end),
  
  move = function(force) return F(function(actor, scene)
    local spd = actor:spd()
    local dir = actor:dir()
    if force.y then spd.y = force.y end
    
    local kx, kz = dir.x, dir.z
    if not (kx == 0) then spd.x, dir.x = kx * (force.x or 0), kx end
    if not (kz == 0) then spd.z, dir.z = kz * (force.z or 0), kz end
    
    actor:spd(spd)
    
    return true
  end)
  end,
  
  hitAll = function(hit) return F(function(actor, scene, game)
    local hits = scene:getHits(actor, game)
    List.each(hits, function(other)
      other:dmg(hit.dmg)
      if not (hit.force == nil) then other:force(actor, hit.force) end
    end)
  end)
  end,

  -- Triggers
  isDmg = F(function(actor) return actor:dmg() > 0 end),

  isTargetHit = function(states) return F(function(actor, scene, game, target)
    target = target or actor:target()
    if actor == target then return false end
    if not target then return false end
    if not game.checkHit(actor, target) then return false end
    
    local facing = (actor:flip().h == Math.Sign(target:pos().x - actor:pos().x))
    if not facing then return false end

    local d = actor:dist(target)
    local z = math.max(actor:rad(), target:rad())

    local select = List.select(states, function(state)
      local x = (actor:dim(state).w + target:box().w) * 0.5        
      return (d.x < x) and (d.z < z)
    end)
  
    return not (select == nil)
  end)
  end,

  isHitTarget = F(function(actor, scene)
    local target = actor:target()
    if not target then return false end
    
    local facing = (target:flip().h == Math.Sign(actor:pos().x - target:pos().x))
    if not facing then return false end
      
    local d = target:dist(actor)
    local h = target:disthit(actor)
    
    return (d.x < h.x) and (d.z < h.z)
  end),

  isTargetState = function(pattern) return F(function(actor, scene)
    local target = actor:target()
    if not target then return false end
    
    return not (string.match(target:state(), pattern) == nil)
  end)
  end,
  
  isRange = function(k, max, min) return F(function(actor, scene)
    if not actor:target() then return false end
    
    local dist = actor:distout()
    local ok = true
    if ok and min then ok = ok and (dist[k] >= min) end
    if ok and max then ok = ok and (dist[k] <= max) end
    
    return ok
  end)
  end,

  isKey = function(key) return F(function(actor, scene, game)
    local player = actor:player()
    return game.control[player]:isKey(key)
  end)
  end,

  isKeypress = function(key) return F(function(actor, scene, game)
    local player = actor:player()
    return game.control[player]:isKeypress(key)
  end)
  end,
  
  isFrame = function(nframe) return F(function(actor, scene)
    return actor:isStep() and actor:frame() == nframe
  end)
  end,
      
  isDied = F(function(actor, scene) return actor.info.hp == 0 end),
  isFall = F(function(actor, scene) return actor:spd().y > 0 end),
  isKeyb = F(function(actor, scene) return not (actor:keyb() == false) end),
  isAuto = F(function(actor, scene) return not (actor:auto() == false) end),
  isEnded = F(function(actor, scene) return actor:isEnded() end),
  isTarget = F(function(actor, scene) return not (actor:target() == false) end),  
  
  pick = function(list) return F(function(actor, scene, game)
    return list[math.random(1, #list)](actor, scene, game)
  end)
  end,

  all = function(list) return F(function(actor, scene, game)
    List.each(list, function(rule) rule(actor, scene, game) end)
    return false
  end)
  end,
}
