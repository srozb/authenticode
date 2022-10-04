# when defined(posix):
switch("cincludes", "$projectDir/../src/authenticode/src")
when defined(MacOsX):
  switch("passl", "-L/usr/local/Cellar/openssl@1.1/1.1.1q/lib")
  switch("dynlibOverride", "ssl")  # ??
elif defined(Windows):
  switch("passl", "-LC:\\Program Files\\OpenSSL-Win64\\lib")
  switch("cincludes", "C:\Program Files\\OpenSSL-Win64\\include")
switch("passl", "-lcrypto")
