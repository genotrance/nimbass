# Package

version       = "0.1.1"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.1.1"

import distros

var cmd = ""
if detectOs(Windows):
    cmd = "cmd /c "

task setup, "Download and generate":
    exec cmd & "nimgen nimbass.cfg"

before install:
    setupTask()

task test, "Test nimbass":
    exec "nim c -d:nimDebugDlOpen tests/basstest.nim"
    withDir("nimbass"):
        exec "../tests/basstest"
