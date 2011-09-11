create apk

"AneLab-IconBmpData-ane.ane" include in /libs（add build path）

example)
cd /Applications/eclipse3.7/workspace/AneLab-IconBmpData-app
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -target apk -storetype pkcs12 -keystore test.p12 AneLabIconBmpData.apk bin-debug/AneLabIconBmpData-app.xml -C bin-debug AneLabIconBmpData.swf -extdir libs

dummy file is test.p12 (password = 0)

project refresh
