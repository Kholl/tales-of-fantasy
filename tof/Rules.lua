--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  attack = {
    chk = function(vars)
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
      
      return vars.hits:size() > 0
    end,
    
    cmd = function(vars)
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
  },

  idle = function(action) return {
    chk = function() return actor:action() == false and not (actor:state() == action) end,
    cmd = function() actor:start(action) end,
  } end,

  action = function(action) return {
    chk = function()
      return actor:action() == action
    end,
    cmd = function()    
      if not (actor:state() == action) then actor:start(action) end
      
      local state = actor.info.state[action]
      if state.spd then
        actor:spd{
          x = actor.info.dir.x * (state.spd.x or 0),
          z = actor.info.dir.z * (state.spd.z or 0),
          y = state.spd.y or 0}
      end
    end,
  } end,

  finish = function(action) return {
    chk = function() return actor:curr():isEnded() end,
    cmd = function() actor:start(action) end,
  } end,

  died = function(action) return {
    chk = function() return actor.info.hp == 0 end,
    cmd = function() actor:start(action) end,
  } end,

  chain = function(action) return {
    chk = function() return actor:curr():isEnded() and actor:action() == action end,
    cmd = function() actor:start(action) end,
  } end,

  floor = function(action) return {
    chk = function() return actor:floor() end,
    cmd = function() actor:start(action) end,
  } end,

  nofloor = function(action) return {
    chk = function() return not actor:floor() end,
    cmd = function() actor:start(action) end,
  } end,

  fall = function(action) return {
    chk = function() return actor:spd().y > 0 end,
    cmd = function() actor:start(action) end,
  } end,
}
