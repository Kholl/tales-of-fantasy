--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

if arg and arg[#arg] == "-debug" then require("mobdebug").start() end

__DEBUG = (arg and arg[#arg] == "-debug")
__TEST = true

require("lib/Moo")
Moo.Import()

Dependency "window" (love.window)
Dependency "graphics" (love.graphics)
Dependency "keyboard" (love.keyboard)
Dependency "filesystem" (love.filesystem)

require("lib/game/Resources")
Dependency "resource" (Resources.new{
  image = love.image.newImageData,
})

require("lib/game/ctrl/Scene")

local game
love.load = function(arg)
  game = loadfile("game/main.lua")()

  love.filesystem.setIdentity(game.dir)
  love.filesystem.mkdir(love.filesystem.getSaveDirectory())
  love.graphics.setMode(game.view.w, game.view.h, game.view.full, game.view.sync)  
  
  scene = Scene.new(game.scenes.palace)
  scene:update(game) -- Preloads with delta 0
end

love.draw = function()
  scene:draw(game)
end

love.update = function(delta)
  delta = math.min(delta, 1/game.fps)
  scene:delta(delta)
  scene:update(game)
end