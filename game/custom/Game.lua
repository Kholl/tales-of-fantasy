--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/Anim")
require("game/custom/Asset")
require("lib/game/beat/Beat")

Game = {}
Game.check = F{function(actor, scene, game, target)
  target = target or actor:target()
  return not (actor:extra("faction") == target:extra("faction"))
end}

Game.hit = function(atk) return F{function(actor, scene, game, target)
  atk = atk or {}
  target = target or actor:target()

  if target:state() == "die" then return end
  if target:state() == "blk" and not (actor:flip().h == target:flip().h) then
    local hvy = atk.hvy or {x = 1}
    target:force(actor, XYZ{x = 100} * hvy)
    
    return
  end  

  target:state("hit")
  
  if atk.dmg then target:extra("hp", target:extra("hp") - atk.dmg) end
  if atk.hvy then target:force(actor, XYZ{x = 100, y = -100} * atk.hvy) end
end}
end

Game.isHit = function(state) return function(actor, scene, game, target) 
  local check = Game.check(actor, scene, game, target)
  local hit = Beat.Script.isHit(state)(actor, scene, game, target)
  return check and hit
end
end

Game.isHitTarget = Game.check ^ Beat.Script.isHitTarget

Game.hitAll = function(atk) return Beat.Script.hitAll(Game.isHit(), Game.hit(atk)) end
Game.hitChk = function(chk, atk) return Beat.Script.hitAll(Game.check ^ chk, Game.hit(atk)) end
