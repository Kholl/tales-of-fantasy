--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

scan = {
  chk = function() return not actor:target() end,
  cmd = function()
    local selectFunc = function(target) return not (actor == target) end
    local sortFunc = function(targetA, targetB) return 1 end
    
    local target = scene:getActors(selectFunc):sort(sortFunc):first()
    
    if target then
      actor:target(target)
      actor:start("wlk")
    end
  end,
}

wlk = {
  chk = function() return actor:target() end,
  cmd = function()
    actor:state("wlk")
    
    local dist = actor:dist()
    local r = dist.x < -actor.prof.state.atk.rng.x.max
    local d = dist.z < -actor.prof.state.atk.rng.z.max
    local l = dist.x >  actor.prof.state.atk.rng.x.max
    local u = dist.z >  actor.prof.state.atk.rng.z.max
    
    if r then actor:spd().x = actor.prof.spd
    elseif l then actor:spd().x = -actor.prof.spd
    end
    
    if d then actor:spd().z = actor.prof.spd
    elseif u then actor:spd().z = -actor.prof.spd
    end
  
    if r then actor:dir().x = 1
    elseif l then actor:dir().x = -1
    end
  end,
}

jmp = {
  chk = function()
    return actor:target() and actor:floor() and Math.Abs(actor:dist().x) > actor.prof.state.jmp.rng
  end,
  cmd = function() 
    actor:start("jmp")
    actor:spd().y = actor.prof.jmp
  end,
}

atk = {
  chk = function()
    if not actor:target() or not actor:floor() then return false end
    
    local rng = actor.prof.state.atk.rng
    local dist = actor:dist()
    local distX = Math.Abs(dist.x)
    local distZ = Math.Abs(dist.z)
    
    return distX >= rng.x.min and distX <= rng.x.max and
           distZ >= rng.z.min and distZ <= rng.z.max
  end,
  
  cmd = function()
    actor:face()
    actor:start("atk")
  end,
}
      
return {
  std = {wlk, jmp, atk, scan},
  wlk = {wlk, jmp, atk},
}