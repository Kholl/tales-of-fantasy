return {
  at(0) / run("rollOut"),
  at(1) / {
    with("image", {
      prop("img")("game/chars/Lucia/portrait-m.png"),
      prop("pos"){x = 10, y = 0.5},
      prop("dim"){w = 40, h = 60},
      prop("dir"){x =  1, y = 1},
      run("fadeIn"),
      show }),

    with("text", {
      prop("txt")("What happens? Everguardian Telhari, report me."),
      prop("pos"){x = 1, y = 0.5},
      prop("fit"){w = false, h = false},
      run("fadeIn"),
      show }),
  },
  at(6) / {
    with("image", run("fadeOut")),
    with("text",  run("fadeOut")),
  },
  at(7) / {
    with("image", {
      prop("img")("game/chars/TelArin/portrait-m.png"),
      prop("pal")("game/preset/imagefx/HElf.lua"),
      prop("pos"){x = -10, y = 0.5},
      prop("dim"){w = 48, h = 48},
      prop("dir"){x = -1, y = 1},
      run("fadeIn") }),
  
    with("text", {
      prop("txt")("Elfinn Princess, the Green Tower defenses are being attacked by an army of Orq mercenaries. We have to leave the tower through the Hidden Backdoor. I will escort you."),
      prop("pos"){x = 0, y = 0},
      prop("fit"){w = false, h = true},
      with("scroll", prop("len")(6)),
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