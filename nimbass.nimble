# Package

version       = "0.1.3"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.4.0"

var
  name = "nimbass"
  cmd = when defined(Windows): "cmd /c " else: ""
  ext = when defined(Windows): ".exe" else: ""
  ldpath = when defined(Linux): "LD_LIBRARY_PATH=x64 " else: ""

mkDir(name)

task setup, "Checkout and generate":
  if gorgeEx(cmd & "nimgen").exitCode != 0:
    withDir(".."):
      exec "nimble install nimgen -y"
  exec cmd & "nimgen " & name & ".cfg"

before install:
  setupTask()

task test, "Test nimbass":
  exec "nim c -d:nimDebugDlOpen tests/basstest.nim"
  withDir("nimbass"):
    exec ldpath & "../tests/basstest" & ext
