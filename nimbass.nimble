# Package

version       = "0.1.2"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.1.4"

import distros

var cmd = ""
var ldpath = ""
var ext = ""
if detectOs(Windows):
    cmd = "cmd /c "
    ext = ".exe"
if detectOs(Linux):
    ldpath = "LD_LIBRARY_PATH=x64 "

task setup, "Download and generate":
    exec cmd & "nimgen nimbass.cfg"

before install:
    setupTask()

task test, "Test nimbass":
    exec "nim c -d:nimDebugDlOpen tests/basstest.nim"
    withDir("nimbass"):
        exec ldpath & "../tests/basstest" & ext
