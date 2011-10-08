package com.example.ane.nfc.fre.extension.context
{
	import flash.external.ExtensionContext;

	/**
	 * NFCExtensionContext
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class NFCExtensionContext
	{
		private var context:ExtensionContext;

		public function NFCExtensionContext()
		{
			context = ExtensionContext.createExtensionContext(
				"nfc", "type");
		}

		public function getInfo():String {
			return context.call("info") as String;
		}
	}
}