package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.utils.NdefUtil;
import android.app.Activity;
import android.content.Intent;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class NfcNdefExchangeFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Activity a = arg0.getActivity();
		Intent intent = a.getIntent();
		String ret = null;
		if (NfcAdapter.ACTION_NDEF_DISCOVERED.equals(intent.getAction())) {
				ret = NdefUtil.getMessageBody(intent);
		}
		try {
			return FREObject.newObject(ret);
		} catch (Exception e){}
		return null;
	}
}
