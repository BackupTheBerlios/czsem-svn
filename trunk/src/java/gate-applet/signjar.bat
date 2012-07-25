jarsigner --signedjar signed.jar -keystore src/main/keystore/czsem.keystore -storepass %1 target\gate-applet-1.0.jar czsem > err1.txt 2> err2.txt
