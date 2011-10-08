package market.android.anelab.model;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREReadOnlyException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * PurchaseStateChange
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class PurchaseStateChange {

	private String purchaseState;

	private String itemId;

	private String quantity;

	private String purchaseTime;

	private String developerPayload;

	public void setPurchaseState(String purchaseState) {
		this.purchaseState = purchaseState;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public void setPurchaseTime(String purchaseTime) {
		this.purchaseTime = purchaseTime;
	}

	public void setDeveloperPayload(String developerPayload) {
		this.developerPayload = developerPayload;
	}

	public FREObject getFREObject() throws FREWrongThreadException,
		IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREASErrorException, FRENoSuchNameException, FREReadOnlyException {
		FREObject obj = FREObject.newObject(
				"market.anelab.android.model.PurchaseStateChange", null);

		obj.setProperty("purchaseState", getValue(purchaseState));
		obj.setProperty("itemId", getValue(itemId));
		obj.setProperty("quantity", getValue(quantity));
		obj.setProperty("purchaseTime", getValue(purchaseTime));
		obj.setProperty("developerPayload", getValue(developerPayload));

		return obj;
	}

	private FREObject getValue(String value) throws FREWrongThreadException {
		return FREObject.newObject(value);
	}
}
