package com.example.ane.telephoneobj
{
	import flash.external.ExtensionContext;
	import flash.net.registerClassAlias;

	/**
	 * TelephoneObjectExtension
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class TelephoneObjectExtension
	{
		private var context:ExtensionContext;
		public function TelephoneObjectExtension()
		{
			readClass();
			context = ExtensionContext.createExtensionContext(
				"phone", "type");

		}

		public function phone():TelephoneObject {
			return context.call("phone") as TelephoneObject;
		}

		private function readClass():void {
			registerClassAlias(
				"com.example.ane.telephoneobj.TelephoneObject",
				TelephoneObject);
		}
	}
}