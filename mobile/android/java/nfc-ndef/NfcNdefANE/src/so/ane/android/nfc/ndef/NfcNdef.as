package so.ane.android.nfc.ndef
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.InvokeEvent;
	import flash.external.ExtensionContext;

	import so.ane.android.nfc.ndef.event.NfcNdefEvent;

	public class NfcNdef extends EventDispatcher
	{
		private var _context:ExtensionContext = null;
		private var _isSupport:Boolean = false;
		private var _isWrite:Boolean = false;
		private var _getSendMessage:Function = null;
		private var _getWriteMessage:Function = null;

		public function NfcNdef()
		{
			_context = ExtensionContext.createExtensionContext("so.ane.android.nfc.ndef", null);
			_isSupport =Boolean( _context.call("create"));

			if (_isSupport) {
				var app:NativeApplication= NativeApplication.nativeApplication;
				app.addEventListener(Event.ACTIVATE, onActivate);
				app.addEventListener(Event.DEACTIVATE, onDeactivate);
				app.addEventListener(InvokeEvent.INVOKE, onInvoke);
			}
		}

		public function get isSupport():Boolean {
			return _isSupport;
		}

		public function get isWrite():Boolean {
			return _isWrite;
		}

		public function set getSendMessage(func:Function):void {
			_getSendMessage = func;
		}

		public function set getWriteMessage(func:Function):void {
			_getWriteMessage = func;
		}

		public function changeWriteMode(mode:Boolean):Boolean {
			_isWrite = _context.call("writeMode", mode) as Boolean;
			return _isWrite;
		}

		public function sendMessage(msg:String):void {
				_context.call("enabledPush", msg);
		}

		private function onActivate(event:Event):void {
			var text:String = _getSendMessage();
			var msg:* = _context.call("resume", text);
			if (msg is String && msg != null) {
				var nfcNdefEvent:NfcNdefEvent = new NfcNdefEvent(NfcNdefEvent.RECEIVE);
				nfcNdefEvent.data = String(msg);
				dispatchEvent(nfcNdefEvent);
			}
		}

		private function onDeactivate(event:Event):void {
			_context.call("pause");
		}

		private function onInvoke(event:InvokeEvent):void {
			var nfcNdefEvent:NfcNdefEvent = null;
			if (_isWrite) {
				var writeMsg:String =  _getWriteMessage();
				var status:String = _context.call("write", writeMsg) as String;
				var type:String = NfcNdefEvent.WRITE_ERROR;
				switch(status) {
					case "WRITE_OK":
						type = NfcNdefEvent.WRITE_COMPLETE;
						break;
				}
				nfcNdefEvent = new NfcNdefEvent(type);
				nfcNdefEvent.writeStatus = status;
				dispatchEvent(nfcNdefEvent);
			} else {
				var msg:* = _context.call("exchange");
				if (msg is String && msg != null) {
					nfcNdefEvent = new NfcNdefEvent(NfcNdefEvent.RECEIVE);
					nfcNdefEvent.data = String(msg);
					dispatchEvent(nfcNdefEvent);
				}
			}
		}
	}
}