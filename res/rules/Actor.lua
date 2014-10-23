--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

function doWhen(state, chk)
  return {chk = chk, cmd = function() actor:start(state) end}
end

atkhit = function(selector) return {
  chk = function(vars)
    local state = actor.prof.state[selector]
    if not actor:curr():isFrame(state.hit.frm) then return false end
    
    local box = state.hit.box
    local pos, dim, dir = actor:pos(), actor:dim(), actor:dir()
    local off = scene:off()
    
    local hitbox = {
      x = pos.x + box.x*dir.x + off.x,
      y = pos.y + pos.z - dim.h + box.y + off.y,
      w = box.w * dir.x,
      h = box.h}
    
    vars.hits = scene:getHit(hitbox, function(other)
      return not (actor == other)
        and not (other:state() == "hit")
        and not (other:state() == "hitair")
        and not (other:state() == "hitflr")
    end)
    
    return vars.hits:size() > 0
  end,
  
  cmd = function(vars)
    local state = actor.prof.state[selector]
    vars.hits:each(function(i, other)
      local force = state.hit.force
      other:spd{
        x = other:spd().x + actor:dir().x * force.x,
        y = other:spd().y + force.y,
        z = other:spd().z + force.z}
      
      other:start("hit")
      other:face(actor)
    end)
  end}
end

atkend = doWhen("std", function() return actor:curr():isEnded() end)
jmpend = doWhen("std", function() return actor:floor() end)
hitair = doWhen("hitair", function() return not actor:floor() end)
hitflr = doWhen("hitflr", function() return actor:floor() end)
hitend = doWhen("std", function() return actor:curr():isEnded() end)

return {
  -- Basic
  jmp = {jmpend},
  atk = {atkhit "atk", atkend},
  atkjmp = {atkhit "atkjmp", jmpend},
  hit = {hitair, hitend},
  hitair = {hitflr},
  hitflr = {hitend},
  
  -- Special attack slots
  atk1 = {atkhit "atk1"},
  atk2 = {atkhit "atk2"},
  atk3 = {atkhit "atk3"},
  atk4 = {atkhit "atk4"},
  atk5 = {atkhit "atk5"},
  atk6 = {atkhit "atk6"},
  atk7 = {atkhit "atk7"},
  atk8 = {atkhit "atk8"},
  atk9 = {atkhit "atk9"},
}