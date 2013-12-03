package com.chocbanana.ios {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class libBeacon extends EventDispatcher{

		private var _ExtensionContext:ExtensionContext;
		
		public function libBeacon(target:IEventDispatcher=null){
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.ios.iBeacon", null);
			_ExtensionContext.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		
		public function start():void {
			_ExtensionContext.call("start");
		}
		public function stop():void {
			_ExtensionContext.call("stop");

		}
		public function onStatusEventHandler(event:StatusEvent):void{
			dispatchEvent(event);
		}
	}
}