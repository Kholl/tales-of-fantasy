--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

if arg and arg[#arg] == "-debug" then require("mobdebug").start() end

__DEBUG = (arg and arg[#arg] == "-debug")
__TEST = true

require("lib/Moo")
Moo.Import()

Dependency "logger" (io.output())
Dependency "window" (love.window)
Dependency "graphics" (love.graphics)
Dependency "keyboard" (love.keyboard)
Dependency "joystick" (love.joystick)
Dependency "filesystem" (love.filesystem)
Dependency "image" (love.image)

require("lib/game/Resources")
Dependency "resource" (Resources.new{
  file = Moo.Load,
  image = love.image.newImageData,
  font = function(fontName) return love.graphics.newImageFont(fontName, Resources.GLYPH) end,
})

require("lib/game/ui/graphic/Graphic")
require("lib/game/dlgs/Controller")
require("lib/game/dlgs/Keyboard")
require("lib/game/dlgs/Gamepad")
require("lib/game/Script")

local game

love.load = function(arg)
  love.filesystem.mkdir(love.filesystem.getSaveDirectory())
  
  game = Load("game/main.lua")
  game.ui = Graphic.new(game.interface)
  
  game.control = {}
  game.control[1] = Controller.get(game.input[2].controller).new(game.input[2])
  
  game.checkHit = Game.checkHit
  game.checkDmg = Game.checkDmg
  
  love.filesystem.setIdentity(game.dir)
  love.graphics.setMode(game.w, game.h, game.full, game.sync)  
  
  Script.loadScene(game, game.start)
end

love.draw = function()
  game.scene:draw(game)
  game.ui:draw(game)
end

love.update = function(delta)
  delta = math.min(delta, 1/game.fps)
  
  game.scene:update(delta, nil, game)
  game.ui:update(delta, nil, game)
  
  game.control[1]:update(delta, game)
end