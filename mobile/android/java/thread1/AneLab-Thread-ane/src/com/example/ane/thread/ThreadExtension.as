package com.example.ane.thread
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	/**
	 * ThreadExtension
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class ThreadExtension extends EventDispatcher
	{
		public var address:String = "";
		private var _context:ExtensionContext;

		public function ThreadExtension()
		{
			_context = ExtensionContext.createExtensionContext(
				"address", "type");

			_context.addEventListener(StatusEvent.STATUS, onAddressEventHandler);
		}

		public function getAddress(value:String):String {
			return _context.call("address", value) as String;
		}

		public function getData():String {
			return _context.call("data") as String;
		}

		private function onAddressEventHandler(event:StatusEvent):void {
			address = _context.actionScriptData as String;
			dispatchEvent(event);
		}
	}
}