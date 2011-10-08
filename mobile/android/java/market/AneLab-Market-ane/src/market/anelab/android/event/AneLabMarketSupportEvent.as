package market.anelab.android.event
{
	import flash.events.Event;

	/**
	 * AneLabMarketSupportEvent
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class AneLabMarketSupportEvent extends Event
	{
		/** status event code market support  */
		public static const MARKET_SUPPORT:String = "MARKET_SUPPORT";

		private static const MARKET_SUPPORT_LEVEL_ON:String = "1";

		private static const MARKET_SUPPORT_LEVEL_OFF:String = "0";

		private var _isSupport:Boolean = false;

		public function AneLabMarketSupportEvent(
			level:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(MARKET_SUPPORT, bubbles, cancelable);
			_isSupport = MARKET_SUPPORT_LEVEL_ON == level;
		}

		public function isSupport():Boolean {
			return _isSupport;
		}
	}
}