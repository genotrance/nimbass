import strutils

import nimbass/bass
when defined(Windows):
  # libbass_fx.so isn't able to load libbass.so for some reason
  import nimbass/bass_fx

when defined(Windows):
  discard BASS_Init(cint(-1), cast[DWORD](44100), cast[DWORD](0), cast[DWORD](0), nil)

when defined(Linux):
  discard BASS_Init(cint(-1), cast[DWORD](44100), cast[DWORD](0), nil, nil)

echo "Bass: " & $BASS_GetVersion().toHex()

when defined(Windows):
  echo "Bass FX: " & $BASS_FX_GetVersion().toHex()
