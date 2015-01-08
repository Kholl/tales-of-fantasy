--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

if arg and arg[#arg] == "-debug" then require("mobdebug").start() end

require("lib/Moo")
Moo.Import()
Dependency "window" (love.window)
Dependency "graphics" (love.graphics)
Dependency "keyboard" (love.keyboard)
Dependency "resource" (Cache.new{
  image = love.graphics.newImage,
})

require("lib/game/ctrl/Scene")

love.load = function(arg)
  love.graphics.setMode(320, 200)
  scene = Scene.new("res/stages/Palace.lua")
end

love.draw = function()
  scene:draw()
end

love.update = function(delta)
  scene:update(delta)
end