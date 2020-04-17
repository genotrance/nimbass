# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop#head"

import strformat

let
  cache = "$HOME/.cache/nim/nimterop/nimbass"
  cachefx = "$HOME/.cache/nim/nimterop/nimbassfx"

  osDir = when defined(linux): "/x64" else: ""
  osLD = when defined(osx): "DY" else: ""

  bassPath = &"{cache}{osDir}"
  bassfxPath = &"{cachefx}{osDir}"

  ldpath = when defined(posix): &"{osLD}LD_LIBRARY_PATH={bassPath}:{bassfxPath} " else: ""

when defined(windows):
  putEnv("PATH", getEnv("PATH") & &";{bassPath};{bassfxPath}")

when gorgeEx("nimble path nimterop").exitCode == 0:
  import nimterop/docs
  task docs, "Generate docs": buildDocs(@["nimbass/bass.nim", "nimbass/bass_fx.nim"], "build/htmldocs")
else:
  task docs, "Do nothing": discard

task test, "Test nimbass":
  exec "nim c -d:nimDebugDlOpen --path:.. tests/basstest.nim"
  exec ldpath & "./tests/basstest"
