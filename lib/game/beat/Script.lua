--[[
Beat extension for Moo game library
@author Manuel Coll <mkhollv@gmail.com>
]]--

Beat.Script = {
  isTargetHit = function(state) return F{function(actor, scene, game, target)
    target = target or actor:target()
    if not target then return false end
    if actor == target then return false end
    if actor:getData(state) == nil then return false end
    
    if not game.checkHit(actor, target) then return false end
    
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
      
    local d = target:dist(actor)
    local h = target:disthit(actor)
    
    return (d.x < h.x) and (d.z < h.z)
  end},

  hitAll = function(hit) return F{function(actor, scene, game)
    local check = Beat.Script.isTargetHit
    local hit = hit or Nil
    List.each(scene:getActors(check), hit(actor, scene, game))
  end}
  end,
}