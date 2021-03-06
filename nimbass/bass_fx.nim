import os, strutils

import nimterop/[build, cimport]

import "."/bass

const
  baseDir = getProjectCacheDir("nimbassfx")

  dlUrl = "http://uk.un4seen.com/files/z/0/bass_fx$1" & getOsSuffix() & ".zip"

static:
  cDebug()

setDefines(@["bassfxDL", "bassfxSetVer=24"])

proc bassfxPreBuild(outdir, header: string) =
  # Include bass.h for preprocessor macros
  let
    bfxh = findFile("bass_fx.h", outdir, recurse = true, first = true)
  if fileExists(bfxh):
    let
      bfxhd = readFile(bfxh)
    if "bass.h" notin bfxhd:
      writeFile(bfxh, "#include \"bass.h\"\n" & bfxhd)

  rmSharedByArch(outdir, "bass_fx")

getHeader(
  "bass_fx.h",
  dlurl = dlUrl,
  outdir = baseDir
)

cIncludeDir(bassPath.parentDir())

{.passL: "-lbass_fx".}
cImport(bassfxPath, flags = cImportFlags)