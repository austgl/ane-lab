package com.example.ane.iconbmpdata
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;

	/**
	 * IconBmpDataExtension
	 * @author @tokufxug http://twitter.com/tokufxug
	 *
	 */
	public class IconBmpDataExtension
	{
		public function IconBmpDataExtension()
		{
			context = ExtensionContext.createExtensionContext("iconBmpData", "type");
		}

		private var context:ExtensionContext;

		public function iconBmpData():BitmapData {
			return context.call("iconBmpData") as BitmapData;
		}
	}
}