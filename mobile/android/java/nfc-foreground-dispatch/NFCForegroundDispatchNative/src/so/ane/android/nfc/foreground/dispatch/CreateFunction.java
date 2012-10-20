package so.ane.android.nfc.foreground.dispatch;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import static so.ane.android.nfc.foreground.dispatch.NFCForegroundDispatchContext.*;

@TargetApi(10)
public class CreateFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Activity a = arg0.getActivity();

		NFCManager manager = NFCManager.getInstance();
		manager.nfcAdapter = NfcAdapter.getDefaultAdapter(a);

		Intent intent = new Intent(a, a.getClass());
	    intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
	    intent.putExtra(NFC_FOREGROUND_DISPATCH_INTENT_KEY,
	    		NFC_FOREGROUND_DISPATCH_INTENT_VALUE);
	    manager.intent = intent;
	    PendingIntent pendingIntent =  PendingIntent.getActivity(a, 0, intent, 0);
	    manager.pendingIntent = pendingIntent;

		ResumeFunction.onResume(arg0.getActivity());
		return null;
	}
}
