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
    local dist = actor:dist()
    
    actor.cmd = {
      r = dist.x < -actor.prof.rng.x.max,
      d = dist.z < -actor.prof.rng.z.max,
      l = dist.x > actor.prof.rng.x.max,
      u = dist.z > actor.prof.rng.z.max,
    }
  end,
}

jmp = {
  chk = function() return actor:target() and actor:floor() and Math.Abs(actor:dist().x) > actor.prof.rng.jmp end,
  cmd = function() actor.cmd = {jmp = true} end,
}

atk = {
  chk = function()
    if not actor:target() or not actor:floor() then return false end
    
    local rng = actor.prof.rng
    local dist = actor:dist()
    local distX = Math.Abs(dist.x)
    local distZ = Math.Abs(dist.z)
    
    return distX >= rng.x.min and distX <= rng.x.max and
           distZ >= rng.z.min and distZ <= rng.z.max
  end,
  
  cmd = function() actor.cmd = {atk = true} end,
}
      
return {
  std = {wlk, jmp, atk, scan},
  wlk = {wlk, jmp, atk},
}