NimBASS is a [Nim](https://nim-lang.org/) wrapper for the [BASS](http://www.un4seen.com/) audio library.

NimBASS is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimterop](https://github.com/nimterop/nimterop) to generate the wrappers. The BASS library and header files are downloaded using curl/powershell and extracted using unzip/powershell.

__Installation__

NimBASS can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install nimbass
```

This will download, wrap and install NimBASS in the standard Nimble package location, typically ~/.nimble. Once installed, it can be imported into any Nim program.

__Usage__

Module documentation can be found [here](https://genotrance.github.io/nimbass/theindex.html).

```nim
import strutils

import nimbass/bass
import nimbass/bass_fx

discard BASS_Init(cint(-1), cast[DWORD](44100), cast[DWORD](0), cast[DWORD](0), nil)

echo "Bass: " & $BASS_GetVersion().toHex()
echo "Bass FX: " & $BASS_FX_GetVersion().toHex()
```

NimBASS currently wraps BASS and BASS FX and dynamically links to the binaries that get copied to the application executable directory. At runtime, they are loaded with `-rpath`.

__Credits__

NimBASS wraps BASS and all licensing terms of [BASS](http://www.un4seen.com/bass.html#license) apply to the usage of this package.

__Feedback__

NimBASS is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/genotrance/nimbass) with an MIT license so issues, forks and PRs are most appreciated.
