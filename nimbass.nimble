# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop >= 0.6.2"

import os, strformat

when gorgeEx("nimble path nimterop").exitCode == 0:
  import nimterop/docs
  task docs, "Generate docs": buildDocs(@["nimbass/bass.nim", "nimbass/bass_fx.nim"], "build/htmldocs")
else:
  task docs, "Do nothing": discard

task test, "Test nimbass":
  withDir("tests"):
    exec "nim c -f -d:nimDebugDlOpen --path:.. -r basstest.nim"
