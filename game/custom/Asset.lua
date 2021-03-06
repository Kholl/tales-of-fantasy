--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/fx/ImageFX")

Asset = {
  ["high elf pal"] = {
    name = "helf",
    func = ImageFX.mapPixel{
      ["000000"] = {r =  34, g =  85, b =  51},
      ["223355"] = {r = 119, g =  68, b =  34},
      ["444477"] = {r = 153, g = 102, b =  68},
      ["445555"] = {r =  34, g = 136, b =  85},
      ["557777"] = {r =  68, g = 204, b = 136},
      ["6677aa"] = {r = 204, g = 136, b = 102},
      ["9999cc"] = {r = 255, g = 187, b = 136},
      ["ddddff"] = {r = 255, g = 221, b = 204},
    }
  }
}
