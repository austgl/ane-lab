package market.anelab.android.event
{
	import flash.events.Event;

	/**
	 * AneLabMarketPurchaseStateChangeEvent
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class AneLabMarketPurchaseStateChangeEvent extends Event
	{
		/** status event code market PurchaseStateChange  */
		public static const PURCHASE_STATE_CHANGE:String = "PURCHASE_STATE_CHANGE";

		public var purchaseStateChange:String = null;

		public function AneLabMarketPurchaseStateChangeEvent(
			level:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(PURCHASE_STATE_CHANGE, bubbles, cancelable);
			purchaseStateChange = level;
		}
	}
}