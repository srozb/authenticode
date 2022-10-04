{.compile: "src/structs.c".}
{.compile: "src/helper.c".}
{.compile: "src/countersignature.c".}
{.compile: "src/certificate.c".}
{.compile: "src/authenticode.c".}

import src/authenticode
import hexprint
export authenticode, hexprint

iterator items*(x: AuthenticodeArray): ptr Authenticode =
  for i in 0..<x.count:
    yield x.signatures[i]

iterator items*(x: CertificateArray): ptr Certificate =
  for i in 0..<x.count:
    yield x.certs[i]

iterator items*(x: CountersignatureArray): ptr Countersignature =
  for i in 0..<x.count:
    yield x.counters[i]
