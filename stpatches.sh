#!/bin/sh

awk -v mode="$2" '
  function put(id) {
    printf("%s%s, /* color %s */\n",spaces,color[id],name[id])
  }

  BEGIN { colors=0; spaces="	" } # actually tab

  /^base/ { 
            sub(":","",$1)
            tmpname = $1
            sub("base","",$1)
            sub("\"","\"#",$2)
            name[$1] = tmpname
            color[$1] = $2
          }

  END {

    printf("static const char *colorname[] = {\n")
  
    printf("%s/* 8 normal colors */\n",spaces)
    put("00")
    put("08")
    put("0B")
    put("0A")
    put("0D")
    put("0E")
    put("0C")
    put("05")
  
    printf("\n%s/* 8 bright colors */\n",spaces)
    put("03")
    put("08")
    put("0B")
    put("0A")
    put("0D")
    put("0E")
    put("0C")
    put("07")
  
    printf("\n%s/* additional colors */\n",spaces)
    put("09")
    put("0F")
    put("01")
    put("02")
    put("04")
    put("06")
  
    printf("\n%s[255] = 0,\n",spaces)
  
    printf("\n")
    printf("%s/* more colors can be added after 255 to use with DefaultXX */\n",spaces)
  
    if (mode == "light") {
      put("02")
      put("07")
    } else {
      put("05")
      put("00")
    }
  
    printf("};\n")
  }

' "$1"
