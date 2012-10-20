package so.ane.android.nfc.foreground.dispatch;

import android.annotation.TargetApi;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class PauseFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		NfcAdapter adpr = NFCManager.getInstance().nfcAdapter;
		if (adpr != null) {
			adpr.disableForegroundDispatch(arg0.getActivity());
		}
		return null;
	}
}
