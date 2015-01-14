--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

Game = {
  Anim = {
    Air = function(actor)
      return function(sprite)
        local k = actor:spd().y / actor.info.state.jmp.spd.y
        return (sprite.data.nframes) * (1 - k) * 0.5
      end
    end,
  
    Air2 = function(actor)
      return function(sprite)
        if actor:spd().y < 0 then return 0 else return 1 end
      end
    end,
  
    Air3 = function(actor, threshold)
      return function(sprite)
        local value = actor:spd().y
        
        if value < -threshold then return 0
        elseif value > threshold then return 2
        else return 1
        end
      end
    end,
  },
  
  PixelMap = {
    Pal = function(replace)
      return function (x, y, r, g, b, a)
        local key = string.format("%02x%02x%02x", r, g, b)
        local color = replace[key] or {r = r, g = g, b = b}
        return color.r, color.g, color.b, a
      end
    end,
  },
  
  Rule = {
    Auto = {
      notarget = {
        chk = function() return actor.info.auto and not actor:target() end,
        cmd = function()
          local selectFunc = function(target)
            return not (actor == target) and not (actor.info.faction == target.info.faction)
          end

          local sortFunc = function(targetA, targetB)
            return actor:eucl(targetA) < actor:eucl(targetB)
          end

          local target = scene:getActors(selectFunc):sort(sortFunc):first()
          if not target then return end
          
          actor:target(target)
        end,
      },

      target = function(valid) return {
        chk = function() return actor.info.auto and actor:target() end,
        cmd = function()
          actor.info.ep = Math.Lim(actor.info.ep +2, {max = actor.info.epmax})
          
          local dist = actor:dist()
          local eucl = actor:eucl()
          
          actor.info.dir.x = -Math.Sign(dist.x)
          actor.info.dir.z = -Math.Sign(dist.z)
           
          local sel, best = false, 0
          local actions = valid[actor:state()]
          
          Each(actions, function(action)
            if action == actor:action() then return end
            
            local state = actor.info.state[action]
            if not state or
               not state.rng or
               not (state.ep <= actor.info.ep) or
               not Math.InLim(eucl, state.rng) then return end
              
            local val = state.spd and state.spd.x or Math.Rand(1, 10)
            if best < val then sel, best = action, val end
          end)
        
          if sel then actor.info.ep = actor.info.ep - actor.info.state[sel].ep end

          actor:face()
          actor:action(sel)
        end,
      } end,
    },
    
    attack = {
      chk = function(vars)
        local actorState = actor.info.state[actor:state()]
        local hit = actorState.hit[actor:curr():frame()]
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
        local hit = vars.hit
        vars.hits:each(function(i, other)
          other:target(actor)

          if not (other:state() == "blk" and other:facing(actor)) and
             not (other:state() == "hit" or other:state() == "hitalt") then
             
            local action = Math.Pick{"hit", "hitalt"}
            if other.states[action] then other:start(action) else other:start("hit") end
          end
          
          if other.info.massive then return end
          
          local force = hit.force or {}
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
  },
  
  Scene = {
    player = function(scene, name)
      return function(keyset)
        local actor = scene.actors:addNew(string.format("res/chars/%s.lua", name))
        actor:addKeyb(keyset)
        actor:addRules("res/rules/Keyb.lua")
        actor:addRules(string.format("res/rules/%s.lua", name))
        actor.info.auto = false
        return actor
      end
    end,
    
    spawn = function(scene, name)
      local actor = scene.actors:addNew(string.format("res/chars/%s.lua", name))
      actor:addRules(string.format("res/rules/%s.lua", name))
      actor.info.auto = true
      return actor
    end,
  }
}

Game.assets = {}
Game.assets["high elf pal"] = {
  name = "~helf",
  func = Game.PixelMap.Pal{
    ["000000"] = {r =  34, g =  85, b =  51},
    ["223355"] = {r = 119, g =  68, b =  34},
    ["444477"] = {r = 153, g = 102, b =  68},
    ["445555"] = {r =  34, g = 136, b =  85},
    ["557777"] = {r =  68, g = 204, b = 136},
    ["6677aa"] = {r = 204, g = 136, b = 102},
    ["9999cc"] = {r = 255, g = 187, b = 136},
    ["ddddff"] = {r = 255, g = 221, b = 204},
  }
}

return Game