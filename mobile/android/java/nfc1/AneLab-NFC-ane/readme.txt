create ane

jarfile include in platform/android

"AneLab-NFC-ane.swc" rename "AneLab-NFC-ane.zip".

"AneLab-NFC-ane.zip" defreeze.

library.swf include in "platform/android".

example)
cd /Applications/eclipse3.7/workspace/AneLab-NFC-ane
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -storetype pkcs12 -keystore test.p12 -target ane AneLab-NFC-ane.ane extension.xml -swc bin/AneLab-NFC-ane.swc -platform Android-ARM -C platform/android .

dummy file is test.p12 (password = 0)

project refresh


