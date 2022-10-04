import unittest
import authenticode
import authenticode/parser
# import authenticode/hexprint
import std/memfiles

suite "x86dll":
  initialize_authenticode_parser()
  var data = memfiles.open("tests/files/x86dll.bin", mode = fmReadWrite, mappedSize = -1)
  let 
    auth = parse_authenticode(cast[ptr uint8](data.mem), data.size.uint)
    sig = @[auth[].signatures[0], auth[].signatures[1]]
    chain = @[sig[0].signer[].chain[], sig[1].signer[].chain[]]
  data.close()

  test "parsed":    
    check (not auth.isNil)
    check auth[].count == 2

  test "signatures":
    check sig[0].verify_flags == 0
    check sig[1].verify_flags == 0
    check sig[0].version == 1
    check sig[1].version == 1
    check sig[0].digest_alg == "sha1"
    check sig[1].digest_alg == "sha256"
    check sig[0].digest.len == 20
    check sig[1].digest.len == 32
    check ($sig[0].digest) == "49:7f:6b:52:91:a5:56:6c:3b:d1:d2:98:3a:40:81:cf:39:67:d6:33"
    check ($sig[1].digest) == "d0:6f:fd:b4:74:11:4c:f3:c1:44:21:fb:65:f1:e2:17:96:31:1d:4d:5a:7e:2e:e9:9d:b8:aa:b1:ce:56:9f:b5"

  test "signers":
    check sig[0].signer[].digest_alg == "sha1"
    check ($sig[0].signer[].digest) == "00:83:76:b1:65:a8:9d:05:3b:21:c7:29:aa:cf:67:14:43:cc:28:6d"
    check sig[1].signer[].digest_alg == "sha256"
    check ($sig[1].signer[].digest) == "ac:1e:3d:78:71:ad:62:4d:c3:6a:ec:0c:d8:a2:5c:c1:89:4c:9a:57:73:fe:20:20:79:8f:b8:1b:be:c2:50:37"

  test "chains":
    check chain[0].count == 2
    check chain[1].count == 2
    check chain[0].certs[0].version == 2
    check chain[0].certs[0].serial == "0d:9b:e4:34:e9:33:6a:80:f5:9a:f2:60:7d:d7:d7:88"
    check chain[0].certs[0].subject == "/jurisdictionC=CN/jurisdictionST=Shanghai/businessCategory=Private Organization/serialNumber=91310114MA1GT9FP6N"

  test "attributes":
    check ($chain[0].certs[0].subject_attrs.organization) == "Shanghai Changzhi Network Technology Co., Ltd."
    check ($chain[0].certs[0].subject_attrs.organizationalUnit) == "e5:ae:a2:e6:9c:8d:e9:83:a8"
    check ($chain[0].certs[0].subject_attrs.serialNumber) == "91310114MA1GT9FP6N"
    check ($chain[0].certs[0].issuer_attrs.organization) == "DigiCert Inc"
    check ($chain[0].certs[0].issuer_attrs.commonName) == "DigiCert EV Code Signing CA (SHA2)"

  
