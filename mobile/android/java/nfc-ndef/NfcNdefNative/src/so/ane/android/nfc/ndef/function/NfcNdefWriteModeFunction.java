package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.NfcNdefManager;

import android.annotation.TargetApi;
import android.app.Activity;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class NfcNdefWriteModeFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		boolean isWrite = false;
		try {isWrite = arg1[0].getAsBool();}catch(Exception e){}

		if (isWrite) {
			disableNdefExchangeMode(arg0.getActivity());
			NfcNdefManager.getInstance().enableTagWriteMode(arg0.getActivity());
		} else {
			NfcNdefManager.getInstance().adapter.disableForegroundDispatch(arg0.getActivity());
			NfcNdefManager.getInstance().adapter.enableForegroundDispatch(
					arg0.getActivity()
					, NfcNdefManager.getInstance().pIntent
					,  NfcNdefManager.getInstance().ndefFilters
					, null);
		}

		try {return FREObject.newObject(isWrite);} catch (Exception e){}
		return null;
	}

	private void disableNdefExchangeMode(Activity a) {
		NfcNdefManager.getInstance().adapter.disableForegroundNdefPush(a);
		NfcNdefManager.getInstance().adapter.disableForegroundDispatch(a);
    }
}
