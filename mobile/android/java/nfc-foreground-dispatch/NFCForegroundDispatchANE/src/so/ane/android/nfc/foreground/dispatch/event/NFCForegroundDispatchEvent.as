package so.ane.android.nfc.foreground.dispatch.event
{
	import flash.events.Event;

	public class NFCForegroundDispatchEvent extends Event
	{
		public static const NEW_INTENT:String = " NEW_INTENT";
		public var data:String;
		public function NFCForegroundDispatchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}