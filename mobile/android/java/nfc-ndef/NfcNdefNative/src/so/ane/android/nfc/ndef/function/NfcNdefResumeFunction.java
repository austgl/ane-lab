package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.NfcNdefManager;
import so.ane.android.nfc.ndef.utils.NdefUtil;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.nfc.NfcAdapter;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class NfcNdefResumeFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Activity a = arg0.getActivity();
		Intent intent = a.getIntent();
		String msg = null;
		String pushMsg = null;
		NfcNdefManager.getInstance().isResume = true;
		if (NfcAdapter.ACTION_NDEF_DISCOVERED.equals(intent.getAction())) {
			msg = NdefUtil.getMessageBody(intent);
		}
		try {pushMsg = arg1[0].getAsString();}catch(Exception e){}

		if (pushMsg != null) {
			NfcNdefManager.getInstance().enableNdefExchangeMode(a, pushMsg);
		}
		try {
			return FREObject.newObject(msg);
		} catch (Exception e){}
		return null;
	}
}
