--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("game/custom/Anim")
require("game/custom/Asset")

Game = {
  checkHit = function(actor, target)
    return not (actor:extra("faction") == target:extra("faction")) and
           not (target:state() == "blk") and
           string.match(target:state(), "hit-") == nil
  end,
}