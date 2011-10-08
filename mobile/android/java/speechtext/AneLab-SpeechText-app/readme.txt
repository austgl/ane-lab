create apk

"AneLab-SpeechText-ane.ane" include in /libs（add build path）

example)
cd /Applications/eclipse3.7/workspace/AneLab-SpeechText-app
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -target apk -storetype pkcs12 -keystore test.p12 AneLabSpeechText.apk bin-debug/AneLabSpeechText-app.xml -C bin-debug AneLabSpeechText.swf -extdir libs

dummy file is test.p12 (password = 0)

project refresh
