# Package

version       = "0.1.0"
author        = "genotrance"
description   = "Bass wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.1.0"

import distros
import ospaths
import strutils

# URLs
var ver = "24"
var base_url = "http://uk.un4seen.com/files/"
var comps = ["bass", "z/0/bass_fx"]

# OS specific
var os = ""
var cmd = ""
if detectOs(Windows):
    cmd = "cmd /c "
elif detectOs(Linux):
    os = "-linux"
elif detectOs(MacOSX):
    os = "-osx"

var dl_target = ""
var dl_file = ""

task extract, "Extract ZIPs":
    var ext_cmd = "unzip $#"
    if detectOs(Windows):
        ext_cmd = "powershell -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('$#', '.'); }\""

    echo "Extracting " & dl_file
    exec ext_cmd % dl_file

task dl_url, "Download URL":
    var dl_cmd = "curl $#$# -o $#"
    if detectOs(Windows):
        dl_cmd = "powershell wget $#$# -OutFile $#"
    
    echo "Downloading " & dl_file
    exec dl_cmd % [base_url, dl_target, dl_file]

task dl_comps, "Download components":
    for comp in comps:
        dl_target = comp & ver & os & ".zip"
        dl_file = extractFilename(dl_target)
        if not fileExists(dl_file):            
            dl_urlTask()

        extractTask()

task nimgen, "Run nimgen":
    exec cmd & "nimgen nimbass.cfg"

task setup, "Download and extract":
    if dirExists("nimbass"):
        rmDir("nimbass")

    mkDir("nimbass")

    withDir("nimbass"):
        dl_compsTask()

    nimgenTask()

before install:
    setupTask()

task test, "Test nimbass":
    exec "nim c -d:nimDebugDlOpen tests/basstest.nim"
    withDir("nimbass"):
        exec "../tests/basstest"
