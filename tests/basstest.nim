import strutils

import nimbass/bass
import nimbass/bass_fx

discard BASS_Init(cint(-1), cast[DWORD](44100), cast[DWORD](0), cast[DWORD](0), nil)

echo "Bass: " & $BASS_GetVersion().toHex()
echo "Bass FX: " & $BASS_FX_GetVersion().toHex()