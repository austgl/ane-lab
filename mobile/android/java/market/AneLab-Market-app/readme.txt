create apk

"AneLab-Market-ane.ane" include in /libs（add build path）

example)
cd /Applications/eclipse3.7/workspace/AneLab-Market-app
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -target apk -storetype pkcs12 -keystore test.p12 AneLabMarket.apk bin-debug/AneLabMarket-app.xml -C bin-debug AneLabMarket.swf -extdir libs

dummy file is test.p12 (password = 0)

project refresh

Importance

1. Get licensing  public key
   https://market.android.com/publish/editProfile
2. Setting key constants.AneLabMarketConst.Key
