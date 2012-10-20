package so.ane.android.nfc.foreground.dispatch
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.InvokeEvent;
	import flash.external.ExtensionContext;

	import so.ane.android.nfc.foreground.dispatch.event.NFCForegroundDispatchEvent;

	public class NFCForegroundDispatch extends EventDispatcher
	{
		private var _context:ExtensionContext;

		public function NFCForegroundDispatch()
		{
				_context = ExtensionContext.createExtensionContext("so.ane.android.nfc.foreground.dispatch", null);
			  	_context.call("create");

				var app:NativeApplication = NativeApplication.nativeApplication;
				app.addEventListener(Event.ACTIVATE, onActivate);
				app.addEventListener(Event.DEACTIVATE, onDeactivate);
				app.addEventListener(InvokeEvent.INVOKE, onInvoke);
		}

		private function onActivate(event:Event):void {
			_context.call("resume");
		}

		private function onDeactivate(event:Event):void {
			_context.call("pause");
		}

		private function onInvoke(event:InvokeEvent):void {
			var data:* = _context.call("newIntent");
			if (data) {
				var evt:NFCForegroundDispatchEvent = new NFCForegroundDispatchEvent(
					NFCForegroundDispatchEvent.NEW_INTENT);
				evt.data = String(data);
				dispatchEvent(evt);
			}
		}
	}
}