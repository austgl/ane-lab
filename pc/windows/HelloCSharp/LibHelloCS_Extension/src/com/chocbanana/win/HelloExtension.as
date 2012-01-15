package com.chocbanana.win{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class HelloExtension extends EventDispatcher {

		private var _ExtensionContext:ExtensionContext;
		
		public function HelloExtension(target:IEventDispatcher=null) {
			//TODO: implement function
			super(target);
			_ExtensionContext = ExtensionContext.createExtensionContext("com.chocbanana.win.HelloExtension", null);
		}
		
		public function dispose():void{
			_ExtensionContext.dispose();
		}
		public function getHelloCSString():String{
			return _ExtensionContext.call("getCSharpHelloWorld") as String;
		}
	}
}