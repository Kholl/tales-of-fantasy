return {
  at(0) / run("rollOut"),
  at(1) / {
    with("image", {
      prop("img")("game/chars/Morrigan/portrait-l.png"),
      prop("pos"){x = -10, y = 0.5},
      prop("dim"){w = 40, h = 60},
      run("fadeIn"),
      show }),
    
    with("text", {
      prop("txt")("Ha! ha! I got you at last! ...you wont stop me to fulfill my plan..."),
      prop("pos"){x = 0, y = 0},
      prop("fit"){w = false, h = false},
      run("fadeIn"),
      show }),
  },  
  at(4) / {
    with("image", run("fadeOut")),
    with("text",  run("fadeOut")),
  },
  at(5) / {
    with("image", {
      prop("img")("game/chars/TelArin/portrait-m.png"),
      prop("pal")("game/preset/imagefx/HElf.lua"),
      prop("pos"){x = 10, y = 0.5},
      prop("dim"){w = 48, h = 48},
      run("fadeIn") }),
  
    with("text", {
      prop("txt")("What is this? Princess, stay back while I fight! Guards! Protect her!"),
      prop("pos"){x = 1, y = 0.5},
      prop("fit"){w = false, h = false},
      run("fadeIn") }),
  },
  at(9) / {
    with("image", run("fadeOut")),
    with("text",  run("fadeOut")),
  },
  at(10) / run("rollIn"),
  at(11) / kill,
}