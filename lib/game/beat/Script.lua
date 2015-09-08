--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.Script = {  
  hitAll = function(chk, hit) return F{function(actor, scene, game)
    List.each(scene:getActors(), function(target) (chk / hit)(actor, scene, game, target) end)
  end}
  end,

  isHit = function(state) return F{function(actor, scene, game, target)
    target = target or actor:target()
    if actor == target then return false end
    if actor:getData(state) == nil then return false end

    local facing = (actor:flip().h == Math.Sign(target:pos().x - actor:pos().x))
    if not facing then return false end

    local x = (actor:dim(state).w + target:box().w) * 0.5
    local z = math.max(actor:rad(), target:rad())
    local d = actor:dist(target)
    
    return (d.x < x) and (d.z < z)
  end}
  end,

  isHitTarget = F{function(actor, scene)
    local target = actor:target()
    if not target then return false end
    
    local facing = (target:flip().h == Math.Sign(actor:pos().x - target:pos().x))
    if not facing then return false end
      
    local x = (target:dim(state).w + actor:box().w) * 0.5
    local z = math.max(target:rad(), actor:rad())
    local d = target:dist(actor)
    
    return (d.x < x) and (d.z < z)
  end},
}