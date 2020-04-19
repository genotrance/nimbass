# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop#head"

import os, strformat

let
  # Location of bass and bass_fx binaries
  cache =
    when defined(posix):
      getEnv("HOME") / ".cache/nim/nimterop"
    else:
      getEnv("USERPROFILE") / "nimcache\\nimterop"

  # Arch
  osDir = when defined(amd64): "x64" else: ""

  bassPath = cache / "nimbass" / osDir
  bassfxPath = cache / "nimbassfx" / osDir

  # OSX uses DYLD_LIBRARY_PATH
  osLD = when defined(osx): "DY" else: ""

  # Path to .so and .dylib files specified in LD_LIBRARY_PATH
  ldpath = when defined(posix): &"{osLD}LD_LIBRARY_PATH={bassPath}:{bassfxPath} " else: ""

when gorgeEx("nimble path nimterop").exitCode == 0:
  import nimterop/docs
  task docs, "Generate docs": buildDocs(@["nimbass/bass.nim", "nimbass/bass_fx.nim"], "build/htmldocs")
else:
  task docs, "Do nothing": discard

task test, "Test nimbass":
  when defined(windows):
    # Windows searches for DLLs in PATH
    putEnv("PATH", getEnv("PATH") & &";{bassPath};{bassfxPath}")

  exec "nim c -d:nimDebugDlOpen --path:.. tests/basstest.nim"
  exec ldpath & "./tests/basstest"
