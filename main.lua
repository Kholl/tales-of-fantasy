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
Dependency "image" (love.image)

require("lib/game/Resources")
Dependency "resource" (Resources.new{
  image = love.image.newImageData,
})

require("lib/game/ctrl/Scene")
require("lib/game/ctrl/Group")

local game
--local scene
--local ui

love.load = function(arg)
  game = loadfile("game/main.lua")()

  love.filesystem.setIdentity(game.dir)
  love.graphics.setMode(game.view.w, game.view.h, game.view.full, game.view.sync)  
  
  love.filesystem.mkdir(love.filesystem.getSaveDirectory())
  
  game.ui = Group.new(game.interface)
  game.ui:update(0, game) -- Preloads UI with delta 0
  
  game.scene = Scene.new(game.scenes.start)
  game.scene:update(0, game) -- Preloads SCENE with delta 0
  
--  local imageFont = love.graphics.newImageFont("game/fonts/medieval.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 ,;.:-+/%?!")
--  love.graphics.setFont(imageFont)
end

love.draw = function()
  game.scene:draw(game)
  game.ui:draw(game)
  
--  love.graphics.setColor(255, 0, 0)
--  love.graphics.print("Hola mundo! A dormir ya que es tarde.", 5, 5)
end

love.update = function(delta)
  delta = math.min(delta, 1/game.fps)
  
  game.scene:update(delta, game)
  game.ui:update(delta, game)
end