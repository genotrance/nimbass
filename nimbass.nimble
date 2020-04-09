# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop#head"

task test, "Test nimbass":
  exec "nim c -f -r --path:.. tests/basstest.nim"
