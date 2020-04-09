import os, strutils

import nimterop/[build, cimport]

static:
  cDebug()

const
  baseDir = getProjectCacheDir("nimbass")

const
  arch =
    when sizeof(int) == 8: "x64"
    else: ""

when defined(windows):
  const
    osSuffix = ""
    archSuffix = arch
elif defined(linux):
  const
    osSuffix = "-linux"
    archSuffix = arch
elif defined(osx):
  const
    osSuffix = "-osx"
    archSuffix = ""
else:
    doAssert false, "Unsupported OS"

const
  dlUrl = "http://uk.un4seen.com/files/bass24$1.zip" % osSuffix
  fxDlUrl = "http://uk.un4seen.com/files/z/0/bass_fx24$1.zip" % osSuffix

setDefines(@["bassDL"])

getHeader(
  "bass.h",
  dlurl = dlUrl,
  outdir = baseDir
)

# x64 binaries in subdir on Win/Lin
const
  bassLFile = bassLPath.extractFilename()
  bassLBPath = bassLPath.parentDir()
  bassLPathArch =
    if archSuffix.len != 0:
      bassLBPath / archSuffix / bassLFile
    else:
      bassLPath

cImport(bassPath, dynlib = "bassLPathArch", flags = "-f:ast2")