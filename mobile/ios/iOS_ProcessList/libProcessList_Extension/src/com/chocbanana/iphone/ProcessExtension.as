package com.chocbanana.iphone{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class ProcessExtension extends EventDispatcher{
		
		private var _ExtensionContext:ExtensionContext;
		
		public function ProcessExtension(target:IEventDispatcher=null){
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.iphone.ProcessExtension", null);
		}

		public function dispose():void{
			_ExtensionContext.dispose();
		}

		public function getProcessList():Array {
			return _ExtensionContext.call("getProcessList") as Array;
		}
	}
}
