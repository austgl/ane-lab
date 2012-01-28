package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class OutlookExpressExtension extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function OutlookExpressExtension(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.OutlookExpressExtension", null);
		}

		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function getOE_Info():Array {
			return _ExtensionContext.call("GetOutlookExpressInfomation") as Array;
		}
	}
}
