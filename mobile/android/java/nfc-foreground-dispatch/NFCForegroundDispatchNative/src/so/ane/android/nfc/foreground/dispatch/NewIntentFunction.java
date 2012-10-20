package so.ane.android.nfc.foreground.dispatch;

import static so.ane.android.nfc.foreground.dispatch.NFCForegroundDispatchContext.*;
import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.NfcAdapter;
import android.nfc.Tag;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class NewIntentFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Intent intent = arg0.getActivity().getIntent();// NFCManager.getInstance().intent;

		if (!NFC_FOREGROUND_DISPATCH_INTENT_VALUE.equals(
				intent.getStringExtra(NFC_FOREGROUND_DISPATCH_INTENT_KEY))) {
				return null;
		}
		Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
		String s = toByteDataString(tag.getId());

		FREObject ret = null;
		try {
			ret = FREObject.newObject(s);
		} catch (Exception e) {}
		return ret;
	}

	private String toByteDataString(byte[] b) {
        StringBuilder data = new StringBuilder();
        int len = b.length;
        for(int i = 0; i < len; i++) {
        	data.append(String.format("%02X" ,b[i]));
        }
        return data.toString();
	}
}
