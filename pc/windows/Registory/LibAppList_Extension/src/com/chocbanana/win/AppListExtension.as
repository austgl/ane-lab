package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class AppListExtension extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function AppListExtension(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.AppListExtension", null);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function getAppList():Array{
			return _ExtensionContext.call("GetAppList") as Array;
		}
	}
}