package com.example.extension.context
{
	import flash.external.ExtensionContext;

	public class HelloNdkExtensionContext
	{
		private var context:ExtensionContext;

		public function HelloNdkExtensionContext()
		{
			context = ExtensionContext.createExtensionContext(
				"ndk", "type");
		}

		public function helloNDK():String {
			return context.call("GetHelloWorld") as String;
		}
	}
}