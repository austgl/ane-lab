package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.NfcNdefManager;
import android.annotation.TargetApi;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class NfcNdefPauseFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		NfcAdapter adapter = NfcNdefManager.getInstance().adapter;
		NfcNdefManager.getInstance().isResume = false;
		if (adapter != null) {
			adapter.disableForegroundDispatch(arg0.getActivity());
		}
		return null;
	}
}
