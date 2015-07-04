## what
[base16](https://github.com/chriskempson/base16) colorshemes for [st](http://st.suckless.org/) as patches against current git.

## how
before running make, apply a patch of your choosing

    patch < /path/to/base16-st/base16-shapeshifter.light.256.patch

patch will change `config.def.h`, so you will also have to delete `config.h`, if present, for changes to take effect
