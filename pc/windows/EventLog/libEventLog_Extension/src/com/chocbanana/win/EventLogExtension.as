package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExtensionContext;
	
	public class EventLogExtension extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function EventLogExtension(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.EventLogExtension", null);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function getEventLog(entryName:String):Array{
			return _ExtensionContext.call("GetEventLog", entryName) as Array;
		}
	
	}
}
