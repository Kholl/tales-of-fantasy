--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Script = {
  -- Mixed actions
  act = function(action) return F{function(actor, scene, game)
    local object = actor or scene
    object:state(action)
  end}
  end,
    
  with = function(name, script) return F{function(actor, scene, game)
    local object = nil
    
    if not (actor == nil) then object = actor:get(name) end
    if object == nil then object = scene:get(name) end
    if object == nil then object = scene:actor(name) end
    
    script(object, scene, game)
  end}
  end,

  run = function(name) return F{function(actor, scene, game)
    local object = actor or scene
    object:run(name)
  end}
  end,

  -- Camera only Actions
  focus = function(target) return F{function(camera)
    camera:focus(target)
  end}
  end,

  unfocus = F{function(camera) camera:unfocus() end},

  -- Actor only Actions    
  face = F{function(actor, scene, game) actor:face() end},

  dir = function(dir) return F{function(actor, scene, game)
    actor:dir(dir)
  end}
  end,
  
  pos = function(pos) return F{function(actor, scene, game)
    actor:pos(pos)
  end}
  end,

  spd = function(spd) return F{function(actor, scene, game)
    actor:spd(spd)
  end}
  end,
  
  move = function(force, k) return F{function(actor, scene, game)
    local k = k or {}
    local spd = actor:spd()
    local dir = actor:dir()
    if force.y then spd.y = force.y end
    
    local kx, kz = dir.x, dir.z
    if not (kx == 0) then spd.x, dir.x = kx * (force.x or 0), kx end
    if not (kz == 0) then spd.z, dir.z = kz * (force.z or 0), kz end
    
    actor:spd(XYZ(spd) * XYZ(k))
    
    return true
  end}
  end,
  
  force = function(force) return F{function(actor, scene, game)
    actor:force(force)
  end}
  end,

  script = function(script) return F{function(actor, scene, game)
    actor:script(script)
  end}
  end,
  
  -- Actor only Triggers
  isAct = function(pattern) return F{function(actor, scene)
    local target = actor:target()
    if not target then return false end
    
    return not (string.match(target:state(), pattern) == nil)
  end}
  end,
  
  isRng = function(k, max, min) return F{function(actor, scene)
    if not actor:target() then return false end
    
    local dist = actor:distout()
    
    local ok = true
    if min then ok = ok and (dist[k] >= min) end
    if max then ok = ok and (dist[k] <= max) end
    
    return ok
  end}
  end,

  isKey = function(key) return F{function(actor, scene, game)
    local player = actor:player()
    return game.control[player] and game.control[player]:isKey(key)
  end}
  end,

  isKeypress = function(key) return F{function(actor, scene, game)
    local player = actor:player()
    return game.control[player]:isKeypress(key)
  end}
  end,
  
  isFrame = function(nframe) return F{function(actor, scene)
    return actor:isStep() and actor:frame() == nframe
  end}
  end,
  
  isFloor = F{function(actor, scene) return scene.phys:isFloor(actor) end},

  isFall = F{function(actor, scene) return actor:spd().y > 0 end},
  isKeyb = F{function(actor, scene) return not (actor:keyb() == false) end},
  isAuto = F{function(actor, scene) return not (actor:auto() == false) end},
  isEnded = F{function(actor, scene) return actor:isEnded() end},
  isTarget = F{function(actor, scene) return not (actor:target() == false) end},  
  
  pick = function(list) return F{function(actor, scene, game)
    return list[math.random(1, #list)](actor, scene, game)
  end}
  end,
  
  -- Custom extra properties
  extra = function(key) return {
    gt = function(val) return F{function(actor) return actor:extra(key) > val end} end,
    lt = function(val) return F{function(actor) return actor:extra(key) < val end} end,
    eq = function(val) return F{function(actor) return actor:extra(key) == val end} end,   
    leq = function(val) return F{function(actor) return actor:extra(key) <= val end} end,   
    geq = function(val) return F{function(actor) return actor:extra(key) >= val end} end,   
    set = function(val) return F{function(actor) actor:extra(key, val) end} end,

    inc = function(inc) return F{function(actor)
      local val = actor:extra(key)
      return actor:extra(key, val + inc)
    end}
    end,
    
    dec = function(dec) return F{function(actor)
      local val = actor:extra(key)
      return actor:extra(key, val - dec)
    end}
    end,
  } end,

  -- Scene only actions
  dialog = function(id) return F{function(actor, scene, game)
    game.ui:add(Dialog.new("game/preset/dialog/Dialog.lua", Load("game/stages/dialog/".. id)))
  end}
  end,

  focus = function(target) return F{function(actor, scene, game)
    scene:get("camera"):focus(target)
  end}
  end,
  
  spawn = function(key, init, custom) return F{function(actor, scene, game)
    scene:addActor(key, init, custom)
  end}
  end,

  all = function(names, script) return F{function(actor, scene, game)
    List.each(scene:getActors(names), function(object) script(object, scene, game) end)
  end}
  end,

  -- Scene only triggers
  at = function(start, finish) return F{function(actor, scene, game)
    finish = finish or start + 1 / game.fps
    return scene:time() >= start and scene:time() < finish
  end}
  end,
  
  -- Game only actions
  loadScene = function(name) return F{function(actor, scene, game)
    game.scene = Scene.new(name)
    game.ui:time(0)
    
    game.scene:step(game)
    game.scene:update(0, nil, game)
    
    game.ui:step(game)
    game.ui:update(0, nil, game)
  end}
  end,
}
