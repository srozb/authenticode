switch("cincludes", "$projectDir/../src/authenticode/src")
when defined(MacOsX):
  switch("passl", "-L/usr/local/Cellar/openssl@1.1/1.1.1q/lib")
switch("passl", "-lcrypto")
switch("dynlibOverride", "ssl")

# switch("path", "$projectDir/../src")