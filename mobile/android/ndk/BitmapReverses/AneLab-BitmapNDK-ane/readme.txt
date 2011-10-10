create ane

jarfile include in platform/android

"AneLab-BitmapNDK-ane.swc" rename "AneLab-BitmapNDK-ane.zip".

"AneLab-BitmapNDK-ane.zip" defreeze.

library.swf include in "platform/android".

example)
cd /Applications/eclipse3.7/workspace/AneLab-BitmapNDK-ane
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -storetype pkcs12 -keystore test.p12 -target ane AneLab-BitmapNDK-ane.ane extension.xml -swc bin/AneLab-BitmapNDK-ane.swc -platform Android-ARM -C platform/android .

dummy file is test.p12 (password = 0)

project refresh


