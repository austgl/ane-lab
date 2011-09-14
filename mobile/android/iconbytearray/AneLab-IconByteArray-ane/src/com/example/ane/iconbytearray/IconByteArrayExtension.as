package com.example.ane.iconbytearray
{
	import flash.external.ExtensionContext;
	import flash.utils.ByteArray;

	/**
	 * IconByteArrayExtension
	 * @author @tokufxug http://twitter.com/tokufxug
	 *
	 */
	public class IconByteArrayExtension
	{
		private var context:ExtensionContext;

		public function IconByteArrayExtension()
		{
			context = ExtensionContext.createExtensionContext(
				"iconByteArray", "type");
		}

		public function iconByteArray():ByteArray {
			return context.call("iconByteArray") as ByteArray;
		}
	}
}