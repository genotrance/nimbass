import os, strutils

import nimterop/[build, cimport]

proc getOsSuffix*(): string =
  when defined(linux):
    result = "-linux"
  elif defined(osx):
    result = "-osx"

proc rmSharedByArch*(outdir, name: string) =
  # Delete shared lib that doesn't match current architecture
  if sizeof(int) == 4:
    if fileExists(outdir / "x64"):
      rmDir(outdir / "")
  else:
    let
      shared = DynlibFormat % name
    if fileExists(outdir / shared):
      rmFile(outdir / shared)

const
  baseDir = getProjectCacheDir("nimbass")

  dlUrl = "http://uk.un4seen.com/files/bass$1" & getOsSuffix() & ".zip"

static:
  cDebug()
  cSkipSymbol(@["STREAMPROC_DUMMY", "STREAMPROC_PUSH", "STREAMPROC_DEVICE", "STREAMPROC_DEVICE_3D"])

setDefines(@["bassDL", "bassSetVer=24"])

proc bassPreBuild(outdir, header: string) =
  rmSharedByArch(outdir, "bass")

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
  cImportFlags* = (when defined(windows): " -C:stdcall" else: "")

# Link instead of dynlib - other bass binaries like bass_fx need bass loaded
# globally. Also, nimterop copies shared libs to executable path so set
# `-rpath=.` so that libs are found in current directory at runtime.
{.passL: "-Wl,-rpath -Wl,. -L. -lbass".}
cImport(bassPath, flags = cImportFlags)