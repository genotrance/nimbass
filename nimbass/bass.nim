import os, strutils

import nimterop/[build, cimport]

proc getArchSuffix(): string =
  when not defined(osx) and sizeof(int) == 8:
    result = "x64"

proc getOsSuffix*(): string =
  when defined(linux):
    result = "-linux"
  elif defined(osx):
    result = "-osx"

proc getArchLibPath*(lpath: string): string =
  let
    lpathFile = lpath.extractFilename()
    lpathBPath = lpath.parentDir()
    archSuffix = getArchSuffix()

  # x64 binaries in subdir on Win/Lin
  result =
    if archSuffix.len != 0:
      lpathBPath / archSuffix / lpathFile
    else:
      lpath

const
  baseDir = getProjectCacheDir("nimbass")

  dlUrl = "http://uk.un4seen.com/files/bass$1" & getOsSuffix() & ".zip"

static:
  cDebug()

setDefines(@["bassDL", "bassSetVer=24"])

getHeader(
  "bass.h",
  dlurl = dlUrl,
  outdir = baseDir
)

when hostOS=="windows":
  cOverride:
    type
      HWND* = uint32
      GUID* = uint32
      WORD* = uint32
      DWORD* = uint32
      BYTE* = uint8
      BOOL* = uint8

const
  bassLPathArch = getArchLibPath(bassLPath)

when defined(windows):
  cImport(bassPath, dynlib = "bassLPathArch", flags = "-f:ast2")
else:
  # Link instead of dynlib - other bass binaries need bass.dll/so
  {.passL: "-L" & bassLPathArch.parentDir() & " -lbass".}
  cImport(bassPath, flags = "-f:ast2")