--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

Game = {}
Game.Anim = require("res/game/Anims")
Game.PixelMap = require("res/game/PixelMaps")
Game.Assets = require("res/game/Assets")
Game.Gui = require("res/game/Gui")

require("res/game/ctrl/Enemy")
Game.Enemy = Enemy

return Game