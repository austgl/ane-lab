package com.example.ane.speechtext
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class SpeechTextExtension
	{
		private var _context:ExtensionContext;

		public function SpeechTextExtension()
		{
			_context =
				ExtensionContext.createExtensionContext(
					"speech", "type");
		}

		public function speech():String {
			return _context.call("speech") as String;
		}

		public function speechData():String {
			return _context.call("speechData") as String;
		}

		public function end(lastTwieet:String):void {
			_context.call("end", lastTwieet);
		}
	}
}