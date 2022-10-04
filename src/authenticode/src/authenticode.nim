{.push hint[ConvFromXtoItselfNotNeeded]: off.}

import std/time_t as std_time_t
type time_t* = std_time_t.Time


{.pragma: impauthenticodeHdr, header: "authenticode-parser/authenticode.h".}
{.experimental: "codeReordering".}
const
  AUTHENTICODE_VFY_VALID* = 0
  AUTHENTICODE_VFY_CANT_PARSE* = 1
  AUTHENTICODE_VFY_NO_SIGNER_CERT* = 2
  AUTHENTICODE_VFY_DIGEST_MISSING* = 3
  AUTHENTICODE_VFY_INTERNAL_ERROR* = 4
  AUTHENTICODE_VFY_NO_SIGNER_INFO* = 5
  AUTHENTICODE_VFY_WRONG_PKCS7_TYPE* = 6
  AUTHENTICODE_VFY_BAD_CONTENT* = 7
  AUTHENTICODE_VFY_INVALID* = 8
  AUTHENTICODE_VFY_WRONG_FILE_DIGEST* = 9
  AUTHENTICODE_VFY_UNKNOWN_ALGORITHM* = 10
  COUNTERSIGNATURE_VFY_VALID* = 0
  COUNTERSIGNATURE_VFY_CANT_PARSE* = 1
  COUNTERSIGNATURE_VFY_NO_SIGNER_CERT* = 2
  COUNTERSIGNATURE_VFY_UNKNOWN_ALGORITHM* = 3
  COUNTERSIGNATURE_VFY_INVALID* = 4
  COUNTERSIGNATURE_VFY_CANT_DECRYPT_DIGEST* = 5
  COUNTERSIGNATURE_VFY_DIGEST_MISSING* = 6
  COUNTERSIGNATURE_VFY_DOESNT_MATCH_SIGNATURE* = 7
  COUNTERSIGNATURE_VFY_INTERNAL_ERROR* = 8
  COUNTERSIGNATURE_VFY_TIME_MISSING* = 9
type
  ByteArray* {.bycopy, importc, impauthenticodeHdr.} = object
    data*: ptr uint8
    len*: cint

  Attributes* {.bycopy, importc, impauthenticodeHdr.} = object
    country*: ByteArray
    organization*: ByteArray
    organizationalUnit*: ByteArray
    nameQualifier*: ByteArray
    state*: ByteArray
    commonName*: ByteArray
    serialNumber*: ByteArray
    locality*: ByteArray
    title*: ByteArray
    surname*: ByteArray
    givenName*: ByteArray
    initials*: ByteArray
    pseudonym*: ByteArray
    generationQualifier*: ByteArray
    emailAddress*: ByteArray

  Certificate* {.bycopy, importc, impauthenticodeHdr.} = object
    version*: clong
    issuer*: cstring
    subject*: cstring
    serial*: cstring
    sha1*: ByteArray
    sha256*: ByteArray
    key_alg*: cstring
    sig_alg*: cstring
    sig_alg_oid*: cstring
    not_before*: time_t
    not_after*: time_t
    key*: cstring
    issuer_attrs*: Attributes
    subject_attrs*: Attributes

  CertificateArray* {.bycopy, importc, impauthenticodeHdr.} = object
    certs*: ptr UncheckedArray[ptr Certificate]
    count*: uint

  Countersignature* {.bycopy, importc, impauthenticodeHdr.} = object
    verify_flags*: cint
    sign_time*: time_t
    digest_alg*: cstring
    digest*: ByteArray
    chain*: ptr CertificateArray

  CountersignatureArray* {.bycopy, importc, impauthenticodeHdr.} = object
    counters*: ptr UncheckedArray[ptr Countersignature]
    count*: uint

  Signer* {.bycopy, importc, impauthenticodeHdr.} = object
    digest*: ByteArray
    digest_alg*: cstring
    program_name*: cstring
    chain*: ptr CertificateArray

  Authenticode* {.bycopy, importc, impauthenticodeHdr.} = object
    verify_flags*: cint
    version*: cint
    digest_alg*: cstring
    digest*: ByteArray
    file_digest*: ByteArray
    signer*: ptr Signer
    certs*: ptr CertificateArray
    countersigs*: ptr CountersignatureArray

  AuthenticodeArray* {.bycopy, importc, impauthenticodeHdr.} = object
    signatures*: ptr UncheckedArray[ptr Authenticode]
    count*: uint

proc initialize_authenticode_parser*() {.importc, cdecl, impauthenticodeHdr.}
proc parse_authenticode*(peData: ptr uint8; peLen: uint64): ptr AuthenticodeArray {.
    importc, cdecl, impauthenticodeHdr.}
proc authenticode_new*(data: ptr uint8; len: clong): ptr AuthenticodeArray {.
    importc, cdecl, impauthenticodeHdr.}
proc authenticode_array_free*(auth: ptr AuthenticodeArray) {.importc, cdecl,
    impauthenticodeHdr.}
{.pop.}
