create ane

jarfile include in platform/android

"AneLab-HelloNDK-ane.swc" rename "AneLab-HelloNDK-ane.zip".

"AneLab-HelloNDK-ane.zip" defreeze.

library.swf include in "platform/android".

example)
cd /Applications/eclipse3.7/workspace/AneLab-HelloNDK-ane
/Applications/Adobe\ Flash\ Builder\ 4.5/sdks/4.5.1/bin/adt -package -storetype pkcs12 -keystore test.p12 -target ane AneLab-HelloNDK-ane.ane extension.xml -swc bin/AneLab-HelloNDK-ane.swc -platform Android-ARM -C platform/android .

dummy file is test.p12 (password = 0)

project refresh


