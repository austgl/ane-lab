package com.example.extension.context
{
	import flash.external.ExtensionContext;

	/**
	 * HelloNdkExtensionContext
	 * @author @tokufxug http://twitter.com/tokufxug
	 *
	 */
	public class HelloNdkExtensionContext
	{
		private var context:ExtensionContext;

		public function HelloNdkExtensionContext()
		{
			context = ExtensionContext.createExtensionContext(
				"ndk", "type");
		}

		public function helloNDK(value:String = "Hello World "):String {
			return context.call("GetHelloWorld", value) as String;
		}
	}
}