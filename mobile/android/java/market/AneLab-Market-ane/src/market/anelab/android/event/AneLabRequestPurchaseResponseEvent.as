package market.anelab.android.event
{
	import flash.events.Event;

	/**
	 * AneLabRequestPurchaseResponseEvent
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class AneLabRequestPurchaseResponseEvent extends Event
	{
		public static const REQUEST_PURCHASE_RESPONSE:String = "REQUEST_PURCHASE_RESPONSE";
		public var result:String;
		public function AneLabRequestPurchaseResponseEvent(
			level:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(REQUEST_PURCHASE_RESPONSE, bubbles, cancelable);
			result = level;
		}
	}
}