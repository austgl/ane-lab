package so.ane.android.nfc.ndef.event
{
	import flash.events.Event;

	public class NfcNdefEvent extends Event
	{
		public static const RECEIVE:String = "RECEIVE";
		public static const WRITE_COMPLETE:String = "WRITE_COMPLETE";
		public static const WRITE_ERROR:String = "WRITE_ERROR";

		public var data:String;
		public var writeStatus:String;

		public function NfcNdefEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}