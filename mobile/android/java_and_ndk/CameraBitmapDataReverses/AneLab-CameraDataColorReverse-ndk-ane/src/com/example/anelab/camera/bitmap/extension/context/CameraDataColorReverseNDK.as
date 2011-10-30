package com.example.anelab.camera.bitmap.extension.context
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;

	/**
	 * CameraDataColorReverseNDK
	 * @author tokufxug
	 * http://twitter.com/tokufxug
	 */
	public class CameraDataColorReverseNDK
	{

		private var ndkReverse:ExtensionContext;

		public function CameraDataColorReverseNDK()
		{
			ndkReverse = ExtensionContext.createExtensionContext(
				"ndkReverse", "type");
		}

		public function reverse(bmpData:BitmapData):String {
			ndkReverse.actionScriptData = bmpData;
			return ndkReverse.call("reverses") as String;
		}

		public function reverseAsm(bmpData:BitmapData):String {
			ndkReverse.actionScriptData = bmpData;
			return ndkReverse.call("reversesAsm") as String;
		}

		public function get bmpData():BitmapData {
			return ndkReverse.actionScriptData as BitmapData;
		}
	}
}