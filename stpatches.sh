#!/bin/sh

[ -f "$1" ] && xrdb -n -load "$1" |
awk '
  BEGIN { spaces="	" } # actually tab

  /foreground/ { fg_color = $2; next }
  /background/ { bg_color = $2; next }
  /cursorColo/ { cs_color = $2; next }

  /color/ { sub(/.*color/,"",$1)
            sub(":","",$1)
            color[$1+0] = $2
            colors++
            if ($2 == fg_color) { fg_num = $1+0 }
            if ($2 == bg_color) { bg_num = $1+0 }
            if ($2 == cs_color) { cs_num = $1+0 }
          }

  END { for(i=0; i<colors; i++) {
          if (i == 0)  printf("%s/* 8 normal colors */\n",spaces)
          if (i == 8)  printf("\n%s/* 8 bright colors */\n",spaces)
          if (i == 16) printf("\n%s/* additional colors */\n",spaces)
          printf("%s\"%s\", /* color %3d */\n",spaces,color[i],i)
        }
        printf("\n%s[255] = 0,\n",spaces)

        # printf("\n\n\n")

        printf("static unsigned int defaultfg = %d;\n",fg_num)
        printf("static unsigned int defaultbg = %d;\n",bg_num)
        printf("static unsigned int defaultcs = %d;\n",cs_num)

      }
'
