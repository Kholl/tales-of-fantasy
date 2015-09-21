return {
  at(0) / run("rollOut"),
  at(1) / {
    with("image", {
      set("img")("game/chars/Lucia/portrait-m.png"),
      set("pos"){x = 10, y = 0.5},
      set("dim"){w = 40, h = 60},
      set("dir"){x =  1, y = 1},
      run("fadeIn"),
      show }),

    with("text", {
      set("txt")("What happens? Everguardian Telhari, report me."),
      set("pos"){x = 1, y = 0.5},
      set("fit"){w = false, h = false},
      run("fadeIn"),
      show }),
  },
  at(6) / {
    with("image", run("fadeOut")),
    with("text",  run("fadeOut")),
  },
  at(7) / {
    with("image", {
      set("img")("game/chars/TelArin/portrait-m.png"),
      set("pal")("game/preset/imagefx/HElf.lua"),
      set("pos"){x = -10, y = 0.5},
      set("dim"){w = 48, h = 48},
      set("dir"){x = -1, y = 1},
      run("fadeIn") }),
  
    with("text", {
      set("txt")("Elfinn Princess, the Green Tower defenses are being attacked by an army of Orq mercenaries. We have to leave the tower through the Hidden Backdoor. I will escort you."),
      set("pos"){x = 0, y = 0},
      set("fit"){w = false, h = true},
      with("scroll", set("len")(6)),
      run("fadeIn") }),
  },
  at(8) / with("text", run("scroll")),
  at(14) / {
    with("image", run("fadeOut")),
    with("text",  run("fadeOut")),
  },
  at(15) / run("rollIn"),
  at(16) / kill,
}