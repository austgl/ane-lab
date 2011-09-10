package com.example.ane.android.helloworld
{
	import flash.external.ExtensionContext;

	/**
	 * HelloWorldExtension
	 * @author @tokufxug http://twitter.com/tokufxug
	 *
	 */
	public class HelloWorldExtension
	{
		private var context:ExtensionContext;

		public function HelloWorldExtension()
		{
			context = ExtensionContext.createExtensionContext("helloWorld", "type");
		}

		public function helloworld(s:String):String {
			return context.call("helloWorld", s) as String;
		}
	}
}