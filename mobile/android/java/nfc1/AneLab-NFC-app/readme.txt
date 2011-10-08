create apk

"AneLab-NFC-ane.ane" include in /libs（add build path）

example)
cd /Applications/eclipse3.7/workspace/AneLab-NFC-app
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -target apk -storetype pkcs12 -keystore test.p12 AneLabNFCApp.apk bin-release-temp/AneLabNFC-app.xml -C bin-release-temp AneLabNFC.swf -extdir libs

dummy file is test.p12 (password = 0)

project refresh
