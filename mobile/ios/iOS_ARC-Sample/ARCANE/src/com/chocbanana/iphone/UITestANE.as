package com.chocbanana.iphone{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class UITestANE extends EventDispatcher{
		
		private var _ExtensionContext:ExtensionContext;
		
		public function UITestANE(target:IEventDispatcher=null){
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.iphone.UITestANE", null);
			_ExtensionContext.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		
		public function getUIControl():void {
			try{
				_ExtensionContext.call("getUIControl");
			}catch(ex:Error){
				trace(ex.message);
			}
		}
		public function onStatusEventHandler(event:StatusEvent):void{
			//trace("Dispatch...");
			dispatchEvent(event);
		}
	}
}
