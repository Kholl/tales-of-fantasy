--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/data/ActorData")

Actor = Class {
  super = State,
  
  data = nil,
  info = nil,
  rules = nil,
  keybdlg = nil,
  actrdlg = nil,
  
  create = function(this, init)
    State.create(this, init)
    this.data = ActorData.new(init)
    this.rules = init.rules or {}
    this.info = init and init.info or {}
    this.keybdlg = false
    this.actrdlg = ActorDlg.new(init.rules)
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    if this.keybdlg then this.keybdlg:update(this, scene) end
    this.actrdlg:update(this, scene)
  end,
  
  keyb = function(this, init) this.keybdlg = KeybDlg.new(init) end,
  
  dim = function(this) return this:curr():dim() end,
  box = function(this) return this:curr():box() end,
  rad = function(this) return this:curr():rad() end,
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,  
  
  think = function(this, scene)
    if not this:target() then
      local selectFunc = function(target)
        return not (this == target)
          and not (this.info.faction == target.info.faction)
          and not (this.info.hp == 0)
      end

      local sortFunc = function(targetA, targetB)
        return this:eucl(targetA) < this:eucl(targetB)
      end

      this:target(scene:getActors(selectFunc):sort(sortFunc):first())
    end
    
    local dist = this:dist()
    local eucl = this:eucl()
    local sel, best = "std", 0
    local actions = this.rules[this:state()]
    
    Each(actions, function(func, action)
      local state = this.info.state[action]
      if not state or not state.rng or not Math.InLim(eucl, state.rng) then return end
      
      local val = state.spd and state.spd.x or Math.Rand(1, 10)
      if best < val then sel, best = action, val end
    end)
  
    local state = this.info.state[sel]
    if not (this:state() == sel) then this:start(sel) end    
    
    if state and state.spd then
      local dir = {x = -Math.Sign(dist.x), y = 1, z = -Math.Sign(dist.z)}
      local spd = this:spd()
      
      spd.x = dir.x * (state.spd.x or spd.x)
      spd.y = dir.y * (state.spd.y or spd.y)
      spd.z = dir.z * (state.spd.z or spd.z)      
      
      this:dir(dir)
      this:spd(spd)
    end
  end,
  
  attack = function(info) return function(this, scene)
    if not this:curr():isStep() then return false end

    local hit = info.hit[this:curr():frame()]
    if not hit then return false end
          
    local atkbox = this:hitbox(scene, hit.box)
    local hits = scene:getHits(this, atkbox):filter(function(other)
      return not (this.info.faction == other.info.faction)
        and Math.InLim(this:eucl(other), info.rng)
    end)
      
    hits:each(function(other)
      other:face(this)
      other:target(this)        
      other.info.hp = Math.Lim(other.info.hp - info.dmg, {min = 0})

      local action
      if other.info.hp > 0
        then action = Math.Pick{"hit", "hitalt"}
        else action = "hitair"
      end
        
      if other.states[action]
        then other:start(action)
        else other:start("hit")
      end
      
      local dist = this:dist(other)
      local face = {
        x = -Math.Sign(dist.x),
        z = -Math.Sign(dist.z)}
      
      local force = hit.force or {}
      if force.x then other:spd().x = face.x * hit.force.x end
      if force.z then other:spd().z = face.z * hit.force.z end
      if force.y then other:spd().y = hit.force.y end
    end)
  end
  end,
  
  move = function(key, info) return function(this, scene, next)
    local isKey = this.keybdlg and this.keybdlg:isKey(key)
    
    if info and info.spd and isKey then
      local spd = this:spd()
      if info.spd.y then spd.y = info.spd.y end
      if this.keybdlg:isUp() then spd.z = -(info.spd.z or 0) end
      if this.keybdlg:isDown() then spd.z = info.spd.z or 0 end
      if this.keybdlg:isLeft() then spd.x, this:dir().x = -info.spd.x or 0, -1 end
      if this.keybdlg:isRight() then spd.x, this:dir().x = info.spd.x or 0,  1 end
      
      this:spd(spd)    
    end
    return isKey
  end
  end,

  isKey = function(key) return function(this)
    return this.keybdlg and this.keybdlg:isKey(key)
  end
  end,
  
  isNoKey = function(this) return this.keybdlg and this.keybdlg:isNoKey() end,
    
  isEnded = function(this) return this:curr():isEnded() end,
  isDied = function(this) return this.info.hp == 0 end,
  isFloor = function(this) return this.data:floor() end,
  noFloor = function(this) return not this:isFloor() end,
  isFall = function(this) return this:spd().y > 0 end,
  isChain = function(key) return function(this)
    return this.keybdlg and this.keybdlg:isKey(key) and this:isEnded()
  end
  end,
  
  dist = function(this, actor)
    actor = actor or this:target()
    return Math.Dist(this:pos(), actor:pos())
  end,
  
  eucl = function(this, actor)
    local d = this:dist(actor)
    return math.sqrt(d.x*d.x + d.y*d.y + d.z*d.z)
  end,
  
  angle = function(this, actor)
    actor = actor or this:target()
    local angle = Math.Angle(this:pos(), actor:pos())
    return {x = math.cos(angle), z = math.sin(angle)}
  end,
  
  face = function(this, actor)
    actor = actor or this:target()
    this:dir().x = Math.Sign(actor:pos().x - this:pos().x)
    return this
  end,
  
  facing = function(this, actor)
    actor = actor or this:target()
    return (this:dir().x * actor:dir().x) == -1
  end,
    
  hitbox = function(this, scene, box)
    box = box or this:box()
    local pos, off = this:pos(), scene:off()
    
    return {
      x = pos.x - box.w*0.5 + off.x,
      y = pos.y + pos.z - box.h + off.y,
      w = box.w,
      h = box.h,
    }
  end,
}
