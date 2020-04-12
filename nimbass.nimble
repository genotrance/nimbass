# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop#head"

let
  ldpath = when defined(Linux): "LD_LIBRARY_PATH=" & "$HOME/.cache/nim/nimterop/nimbass/x64 " else: ""

task test, "Test nimbass":
  exec ldpath & "nim c -d:nimDebugDlOpen -r --path:.. tests/basstest.nim"
