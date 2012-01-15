package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class WinANE extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function WinANE(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.WinANE", null);
			_ExtensionContext.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function Run():void{
			_ExtensionContext.call("Run")
		}
		public function getPcInfo():Pc{
			return _ExtensionContext.call("getPcInfo") as Pc;
		}
		public function onStatusEventHandler(event:StatusEvent):void{
			//if( event.code == "GET_PARAM" ){
				dispatchEvent(event);
				//_ExtensionContext.removeEventListener(StatusEvent.STATUS,  onStatusEventHandler);
			//}
			
			
		}
	}
}