package so.ane.tts.event
{
	import flash.events.Event;

	public class TTSEvent extends Event
	{

		public static const CREATE_STATUS:String = "CREATE_STATUS";
		public static const PLAY_STATUS:String = "PLAY_STATUS";

		public static const CREATE_ERROR:String = "ERROR";
		public static const CREATE_SUCCESS:String = "SUCCESS";
		public static const PLAY_COMPLETED:String = "COMPLETED";

		public function TTSEvent(event:String)
		{
			super(event);
		}
	}
}