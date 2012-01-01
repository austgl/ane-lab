package so.ane.tts.extension
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	import so.ane.tts.event.TTSEvent;

	public class TTSExtension extends EventDispatcher
	{
		private var _context:ExtensionContext;

		public function TTSExtension()
		{
			_context = ExtensionContext.createExtensionContext(
				"so.ane.tts.TTS","");
			_context.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
		}

		public function create():void {
			_context.call("create");
		}

		public function shutdown():void {
			_context.call("shutdown");
		}

		public function stop():void {
			_context.call("stop");
		}

		public function speak(text:String, pitch:Number = 1.0, speechRate:Number = 1.0):void {
			_context.call("speak", text, pitch, speechRate);
		}

		private function onStatusEventHandler(event:StatusEvent):void {
			var code:String = event.code;
			var level:String = event.level;

			switch (code) {
				case TTSEvent.CREATE_STATUS:
					dispatchEvent(new TTSEvent(level));
					break;
				case TTSEvent.PLAY_STATUS:
					dispatchEvent(new TTSEvent(level));
					break;
			}
		}
	}
}