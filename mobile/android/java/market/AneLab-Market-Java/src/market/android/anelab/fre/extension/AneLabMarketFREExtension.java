package market.android.anelab.fre.extension;

import java.util.HashMap;
import java.util.Map;

import market.android.anelab.AneLabBillingReceiverService;
import market.android.anelab.BillingService;
import market.android.anelab.PurchaseObserver;
import market.android.anelab.ResponseHandler;
import market.android.anelab.BillingService.RequestPurchase;
import market.android.anelab.BillingService.RestoreTransactions;
import market.android.anelab.Consts.PurchaseState;
import market.android.anelab.Consts.ResponseCode;
import market.android.anelab.model.PurchaseStateChange;
import static market.android.anelab.fre.extension.AneLabMarketEvent.*;

import android.app.Activity;
import android.os.Handler;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * AneLabMarketFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class AneLabMarketFREExtension implements FREExtension {

	private FREContext freCtxt;
	private AneLabMarketPurchaseObserver mPurchaseObserver;
	private Handler mHandler;
	private BillingService mBService;

	private PurchaseStateChange psc = new PurchaseStateChange();

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return getContext();
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {

	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {

	}

	private FREContext getContext() {
		if (freCtxt != null) {
			return freCtxt;
		}

		freCtxt = new FREContext() {

				@Override
				public Map<String, FREFunction> getFunctions() {
					return getFuncs();
				}

				@Override
				public void dispose() {}
		};
		return freCtxt;
	}

	private Map<String, FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();

		funcs.put("support", isSupport());
		funcs.put("request", request());
		funcs.put("getPurchaseStateChange",
				getPurchaseStateChange());
		funcs.put("exit", exit());
		return funcs;
	}

	private FREFunction isSupport() {

		return new FREFunction() {
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				FREObject oFre = null;

				try {
					Activity a = freCtxt.getActivity();

					mHandler = new Handler();
					mPurchaseObserver = new AneLabMarketPurchaseObserver(a, mHandler);

					mBService = new BillingService(arg1[0].getAsString());
					mBService.setContext(a);
			        ResponseHandler.register(mPurchaseObserver);
			        mBService.checkBillingSupported();
			        AneLabBillingReceiverService.marketService = mBService;

			   } catch (Throwable e) {
			    	try {
			    		oFre = FREObject.newObject(e.toString());
			    	} catch (FREWrongThreadException ex) {}
			    }
				return oFre;
			}
		};
	}

	private FREFunction request() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				String itemCode = null;
				FREObject oRet = null;
				try {

				 	itemCode = arg1[0].getAsString();
					mBService.requestPurchase(itemCode, null);

				} catch (Exception e) {
					try {
						oRet = FREObject.newObject(e.toString());
					} catch (FREWrongThreadException ex) {}
				}
				return oRet;
			}
		};
	}

	private FREFunction getPurchaseStateChange() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				FREObject obj = null;
				try {
					obj = psc.getFREObject();
				} catch (Exception e) {}
				return obj;
			}
		};
	}

	private FREFunction exit() {

		return new FREFunction() {
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				ResponseHandler.unregister(mPurchaseObserver);
				mBService.unbind();
				return null;
			}
		};
	}

	private class AneLabMarketPurchaseObserver extends PurchaseObserver {
        public AneLabMarketPurchaseObserver(Activity a, Handler handler) {
            super(a, handler);
        }

        @Override
        public void onBillingSupported(boolean supported) {
            String level = supported ?
            		MARKET_SUPPORT_LEVEL_ON :
            		MARKET_SUPPORT_LEVEL_OFF;
            freCtxt.dispatchStatusEventAsync(MARKET_SUPPORT_CD, level);
        }

        @Override
        public void onPurchaseStateChange(
        		PurchaseState purchaseState, String itemId,
                int quantity, long purchaseTime, String developerPayload) {

        	psc.setPurchaseState(purchaseState.name());
        	psc.setItemId(itemId);
        	psc.setQuantity(quantity + "");
        	psc.setPurchaseTime(purchaseTime + "");

        	freCtxt.dispatchStatusEventAsync(
        			AneLabMarketEvent.PURCHASE_STATE_CHANGE_CD,
        			purchaseState.name());
        }

        @Override
        public void onRequestPurchaseResponse(RequestPurchase request,
                ResponseCode rc) {
            String response = rc.name() + " itemId = " + request.mProductId;

            freCtxt.dispatchStatusEventAsync(
            		AneLabMarketEvent.REQUEST_PURCHASE_RESPONSE_CD,
            		response);
        }

        @Override
        public void onRestoreTransactionsResponse(RestoreTransactions request,
                ResponseCode responseCode) {
        }
    }
}
