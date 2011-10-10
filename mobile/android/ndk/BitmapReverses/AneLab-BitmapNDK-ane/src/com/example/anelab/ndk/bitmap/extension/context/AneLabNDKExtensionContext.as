package com.example.anelab.ndk.bitmap.extension.context
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;

	/**
	 * AneLabNDKExtensionContext
	 * @author @tokufxug http://twitter.com/tokufxug
	 *
	 */
	public class AneLabNDKExtensionContext
	{
		private var context:ExtensionContext;
		public function AneLabNDKExtensionContext()
		{
			context = ExtensionContext.createExtensionContext(
				"ndkBmp", "type");
		}

		public function reverses(bmpData:BitmapData):String {
			context.actionScriptData = bmpData;
			return context.call("reverses") as String;
		}

		public function get bmpData():BitmapData {
			return context.actionScriptData as BitmapData;
		}
	}
}