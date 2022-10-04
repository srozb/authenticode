import src/authenticode
import strutils


proc hexPrint*(p: ptr uint8, len: int, startAddress = 0): string =
  var i = 0
  while i < len and i < 128:  # cap is 128 bytes
    let b = cast[ptr uint8](cast[int](p) + i)[]
    result.add(toHex(b.int, 2).toLower())
    result.add(":")
    i.inc
  if result.len > 0: result.setLen(result.len - 1)

proc `$`*(b: ByteArray): string = 
  var printable = true
  for i in 0..<b.len:
    let ch = cast[ptr uint8](cast[uint](b.data) + i.uint)[]
    if ord(ch) < 19 or ord(ch) > 128:
      printable = false
  if printable: 
    result = $cast[cstring](b.data)
    result.setLen(b.len)
  else: return hexPrint(b.data, b.len)