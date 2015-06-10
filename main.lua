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
Dependency "filesystem" (love.filesystem)
Dependency "image" (love.image)

require("lib/game/Resources")
Dependency "resource" (Resources.new{
  image = love.image.newImageData,
  font = function(fontName) return love.graphics.newImageFont(fontName, Resources.GLYPH) end,
})

require("lib/game/stage/scene/Scene")
require("lib/game/ui/graphic/Graphic")

local game

love.load = function(arg)
  game = loadfile("game/main.lua")()
  game.dim = function() return { w = game.view.w, h = game.view.h } end
  game.time = 0
  
  love.filesystem.setIdentity(game.dir)
  love.graphics.setMode(game.view.w, game.view.h, game.view.full, game.view.sync)  
  
  love.filesystem.mkdir(love.filesystem.getSaveDirectory())
  
  game.ui = Graphic.new(game.interface)
  game.scene = Scene.new(game.scenes.start)
  
  -- Preload assets
  game.scene:update(0, game)
  game.ui:update(0, game)
end

love.draw = function()
  game.scene:draw()
  game.ui:draw{x = 0, y = 0, w = game.view.w, h = game.view.h}
end

love.update = function(delta)
  delta = math.min(delta, 1/game.fps)
  
  game.scene:update(delta, game)
  game.ui:update(delta, game)
end