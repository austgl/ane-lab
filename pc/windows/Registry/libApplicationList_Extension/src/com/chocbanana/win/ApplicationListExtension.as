package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class ApplicationListExtension extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function ApplicationListExtension(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.ApplicationListExtension", null);
		}

		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function getApplicationList():Array {
			return _ExtensionContext.call("GetApplicationList") as Array;
		}
	}
}
