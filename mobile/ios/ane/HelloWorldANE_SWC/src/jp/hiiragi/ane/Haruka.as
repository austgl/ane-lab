package jp.hiiragi.ane
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;

	public class Haruka extends EventDispatcher
	{
		private var _context:ExtensionContext;
		
		public function Haruka()
		{
			_context = ExtensionContext.createExtensionContext("jp.hiiragi.ane.HelloWorldANE", "type");
		}
		
		public function getHelloWorld():String
		{
			return _context.call("GetHelloWorld") as String;
		}
		
		public function dispose():void
		{
			return _context.dispose();
		}
	}
}