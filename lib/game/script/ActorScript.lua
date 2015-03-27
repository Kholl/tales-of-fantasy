--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorScript = {
  -- Actions  
  act = function(action) return F(function(actor, scene)
    State.start(actor, action)
  end)
  end,
  
  find = F(function(actor, scene)
    local auto = actor:auto()
    local actors = scene:getActors()
    actors = List.filter(actors, auto:filter(actor, scene))
    actors = List.sort(actors, auto:eval(actor, scene))
    actor:target(actors[1])
  end),
  
  move = function(info) return F(function(actor, scene)
    local spd = actor:spd()
    if info.spd.y then spd.y = info.spd.y end
        
    local kx, kz = (actor:keyb() or actor:auto()):direction(actor)
    if not (kx == 0) then spd.x, actor:dir().x = kx * (info.spd.x or 0), kx end
    if not (kz == 0) then spd.z, actor:dir().z = kz * (info.spd.z or 0), kz end
    
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
  
  isKey = function(key) return F(function(actor, scene)
    return actor:keyb() and actor:keyb():isKey(key)
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
