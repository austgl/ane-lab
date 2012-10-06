package com.chocbanana.iphone{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class nativeAlertANE extends EventDispatcher{
		
		private var _ExtensionContext:ExtensionContext;
		
		public function nativeAlertANE(target:IEventDispatcher=null){
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.iphone.nativeAlertANE", null);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		
		public function showNativeAlert(title:String, message:String, cancelButtonTitle:String, otherButtonTitle:String):void {
			try{
				_ExtensionContext.call("showNativeAlert", title, message, cancelButtonTitle, otherButtonTitle);
			}catch(ex:Error){
				trace(ex.message);
			}
		}
	}
}
