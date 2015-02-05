--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  attack = function(actor, action)
    if not actor:curr():isStep() then return false end

    local actorState = actor.info.state[actor:state()]
    local hit = actorState.hit[actor:curr():frame()]
    local dmg = actorState.dmg
    if not hit then return false end
    
    local box = hit.box
    local pos, dim, dir = actor:pos(), actor:dim(), actor:dir()
    local off = scene:off()
    
    local hitbox = {
      x = pos.x + box.x*dir.x + off.x,
      y = pos.y + pos.z - dim.h + box.y + off.y,
      w = box.w * dir.x,
      h = box.h}
    
    local vars = {}
    vars.hit = hit
    vars.dmg = dmg or 0
    vars.hits = scene:getHits(hitbox, function(other)
      local eucl = actor:eucl(other)
      local otherState = other.info.state[other:state()]
      
      return not (actor == other)
        and not (otherState and otherState.evade)
        and not (actor.info.faction == other.info.faction)
        and Math.InLim(eucl, actorState.rng)
    end)
      
    vars.hits:each(function(other)
      other:target(actor)        
      other.info.hp = Math.Lim(other.info.hp - vars.dmg, {min = 0})

      if not (other:state() == "blk" and other:facing(actor)) and
         not (other:state() == "hit" or other:state() == "hitalt") then
        
        local action
        if other.info.hp > 0
          then action = Math.Pick{"hit", "hitalt"}
          else action = "hitair"
        end
        
        if other.states[action]
          then other:start(action)
          else other:start("hit")
        end
      end
      
      local force = vars.hit.force or {}
      local dist = actor:dist(other)
      local face = {
        x = -Math.Sign(dist.x),
        z = -Math.Sign(dist.z)}
      
      other:face()
      if force.x then other:spd().x = face.x * force.x end
      if force.z then other:spd().z = face.z * force.z end
      if force.y then other:spd().y = force.y end
    end)
  end,

  idle = function(actor, action)
    if actor:action() == false and not (actor:state() == action) then
      actor:start(action)
    end
  end,

  action = function(actor, action)
    if not (actor:state() == action) then actor:start(action) end
    
    local state = actor.info.state[action]
    if state.spd then
      actor:spd{
        x = actor.info.dir.x * (state.spd.x or 0),
        z = actor.info.dir.z * (state.spd.z or 0),
        y = state.spd.y or 0}
    end
  end,

  finish = function(actor, action)
    if actor:curr():isEnded() then actor:start(action) end
  end,

  died = function(actor, action)
    if actor.info.hp == 0 then actor:start(action) end
  end,

  chain = function(actor, action)
    if actor:curr():isEnded() and actor:action() == action then actor:start(action) end
  end,

  floor = function(actor, action)
    if actor:floor() then actor:start(action) end
  end,

  nofloor = function(actor, action)
    if not actor:floor() then actor:start(action) end
  end,

  fall = function(actor, action)
    if actor:spd().y > 0 then actor:start(action) end
  end,
}
