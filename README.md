NimBASS is a [Nim](https://nim-lang.org/) wrapper for the [BASS](http://www.un4seen.com/) audio library.

NimBASS is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimgen](https://github.com/genotrance/nimgen) and [c2nim](https://github.com/nim-lang/c2nim/) to generate the wrappers. The BASS library and header files are downloaded using wget/curl/powershell and extracted using unzip/powershell.

__Installation__

NimBASS can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> git clone https://github.com/genotrance/nimbass
> cd nimbass
> nimble install
```

This will download, wrap and install NimBASS in the standard Nimble package location, typically ~/.nimble. Once installed, it can be imported into any Nim program.

__Usage__

```nim
import strutils

import nimbass/bass
import nimbass/bass_fx

discard BASS_Init(cint(-1), cast[DWORD](44100), cast[DWORD](0), cast[DWORD](0), nil)

echo "Bass: " & $BASS_GetVersion().toHex()
echo "Bass FX: " & $BASS_FX_GetVersion().toHex()
```

NimBASS currently wraps the main BASS functions and BASS FX. Make sure to copy the appropriate dll/dylib/so files into the lib path or the executable directory. They will be in the ```~/.nimble/pkgs/nimbass-xxx/nimbass/nimbass``` directory

__Credits__

NimBASS wraps BASS and all licensing terms of [BASS](http://www.un4seen.com/bass.html#license) apply to the usage of this package.

Credits go out to [c2nim](https://github.com/nim-lang/c2nim/) as well without which this package would be greatly limited in its abilities.

__Feedback__

NimBASS is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/genotrance/nimbass) with an MIT license so issues, forks and PRs are most appreciated.
