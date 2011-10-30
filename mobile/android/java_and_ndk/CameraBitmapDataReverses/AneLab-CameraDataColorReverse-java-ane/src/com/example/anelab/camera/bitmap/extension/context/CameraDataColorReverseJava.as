package com.example.anelab.camera.bitmap.extension.context
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;

	/**
	 * CameraDataColorReverseJava
	 * @author tokufxug
	 * http://twitter.com/tokufxug
	 */
	public class CameraDataColorReverseJava
	{

		private var javaReverse:ExtensionContext;

		public function CameraDataColorReverseJava()
		{
			javaReverse = ExtensionContext.createExtensionContext(
				"javaReverse", "type");
		}

		public function reverse(bmpData:BitmapData):String {
			javaReverse.actionScriptData = bmpData;
			return javaReverse.call("reverse4Java") as String;
		}

		public function get bmpData():BitmapData {
			return javaReverse.actionScriptData as BitmapData;
		}
	}
}