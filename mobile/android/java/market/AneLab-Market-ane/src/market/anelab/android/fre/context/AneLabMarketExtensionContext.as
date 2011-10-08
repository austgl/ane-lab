package market.anelab.android.fre.context
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.net.registerClassAlias;

	import market.anelab.android.event.AneLabMarketPurchaseStateChangeEvent;
	import market.anelab.android.event.AneLabMarketSupportEvent;
	import market.anelab.android.event.AneLabRequestPurchaseResponseEvent;
	import market.anelab.android.model.PurchaseStateChange;

	/**
	 * AneLabMarketExtensionContext
	 * @author @tokufxug http://twitter.com/tokufxug
	 */
	public class AneLabMarketExtensionContext extends EventDispatcher
	{
		private var _context:ExtensionContext;

		public function AneLabMarketExtensionContext()
		{
			readClass();
			_context = ExtensionContext.createExtensionContext(
				"market", "type");
			_context.addEventListener(StatusEvent.STATUS, onMarketStatusEventHandler);
		}

		public function useMarket(publicKey:String):void {
			_context.call("support", publicKey);
		}

		public function request(itemId:String):String {
			return _context.call("request", itemId) as String;
		}

		public function purchaseStateChange():PurchaseStateChange {
			return _context.call("getPurchaseStateChange") as PurchaseStateChange;
		}

		public function end():void {
			_context.call("exit");
		}

		private function onMarketStatusEventHandler(event:StatusEvent):void {
			var cd:String = event.code;
			var lvl:String = event.level;
			var evt:*;
			switch (cd) {
				// Market Support
				case AneLabMarketSupportEvent.MARKET_SUPPORT:
					evt = new AneLabMarketSupportEvent(lvl);
					break;
				// Purchase State Change
				case AneLabMarketPurchaseStateChangeEvent.PURCHASE_STATE_CHANGE:
					evt = new AneLabMarketPurchaseStateChangeEvent(lvl);
					break;
				case AneLabRequestPurchaseResponseEvent.REQUEST_PURCHASE_RESPONSE:
					evt = new AneLabRequestPurchaseResponseEvent(lvl);
					break;
			}
			dispatchEvent(evt);
		}

		private function readClass():void {
			registerClassAlias("market.anelab.android.model.PurchaseStateChange",
				PurchaseStateChange);
		}
	}
}