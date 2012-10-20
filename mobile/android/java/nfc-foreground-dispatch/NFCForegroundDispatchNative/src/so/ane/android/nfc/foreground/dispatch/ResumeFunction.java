package so.ane.android.nfc.foreground.dispatch;

import android.annotation.TargetApi;
import android.app.Activity;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class ResumeFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		onResume(arg0.getActivity());
		return null;
	}

	public static void onResume(Activity a) {
		NfcAdapter adpr = NFCManager.getInstance().nfcAdapter;
		if (adpr != null) {
			adpr.enableForegroundDispatch(
					a
					,NFCManager.getInstance().pendingIntent,
					null, null);
		}
	}
}
