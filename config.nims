# when defined(posix):
switch("cincludes", "$projectDir/../src/authenticode/src")
when defined(MacOsX):
  # switch("passl", "-L/usr/local/Cellar/openssl@1.1/1.1.1q/lib") # brew --prefix openssl@1.1
  switch("passl", "-L/usr/local/opt/openssl@1.1/lib")
  switch("dynlibOverride", "ssl")  # ??
elif defined(Windows):
  switch("passl", "-LC:\\Progra~1\\OpenSSL-Win64\\lib")
  switch("cincludes", "C:\\Program Files\\OpenSSL-Win64\\include")
switch("passl", "-lcrypto")
