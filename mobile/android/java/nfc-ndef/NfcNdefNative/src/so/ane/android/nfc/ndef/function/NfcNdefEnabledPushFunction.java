package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.NfcNdefManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class NfcNdefEnabledPushFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		try {
			if (NfcNdefManager.getInstance().isResume) {
	            NfcNdefManager.getInstance().enableForegroundNdefPush(
	            		arg0.getActivity(), arg1[0].getAsString());
	        }
		} catch (Exception e){}
		return null;
	}
}
