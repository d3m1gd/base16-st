## what
[base16](https://github.com/chriskempson/base16) colorshemes for [st](http://st.suckless.org/) as patches against current git.

## how
before building `st`, apply a patch of your choosing

    patch < /path/to/base16-st/shapeshifter.light.patch

or with

    curl -L https://github.com/d3m1gd/base16-st/raw/master/solarized.dark.patch | git apply

Patch will change `config.def.h`, so you will also have to delete `config.h`, if present, for changes to take effect.
