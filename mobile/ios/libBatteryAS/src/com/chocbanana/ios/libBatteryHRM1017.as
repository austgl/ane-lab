package com.chocbanana.ios {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class libBatteryHRM1017 extends EventDispatcher{

		private var _ExtensionContext:ExtensionContext;
		
		public function libBatteryHRM1017(target:IEventDispatcher=null){
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.ios.libBatteryHRM1017", null);
			_ExtensionContext.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function onStatusEventHandler(event:StatusEvent):void{
			dispatchEvent(event);
		}
		
		//public function get():String{
		//	return _ExtensionContext.call("get") as String;
		//}
	}
}
