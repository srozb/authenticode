# Authenticode

[![run tests](https://github.com/srozb/authenticode/actions/workflows/test.yml/badge.svg)](https://github.com/srozb/authenticode/actions/workflows/test.yml)

PE Authenticode parser based on [libyara](https://github.com/VirusTotal/yara) implementation

## Installation

`nimble install authenticode`

## Usage

You'll probably want to parse PE file mapped into memory with 
`parse_authenticode` function, like this:

```Nim
import authenticode
import authenticode/parser
import std/memfiles

initialize_authenticode_parser()

var data = memfiles.open("path/to/pefile.exe", mode = fmReadWrite, mappedSize = -1)
let auth = parse_authenticode(cast[ptr uint8](data.mem), data.size.uint)
```

Consult `tests/testParsing.nim` file for detailed usage.
