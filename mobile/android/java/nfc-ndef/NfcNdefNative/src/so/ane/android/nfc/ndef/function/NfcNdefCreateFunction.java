package so.ane.android.nfc.ndef.function;

import so.ane.android.nfc.ndef.NfcNdefManager;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentFilter.MalformedMimeTypeException;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(10)
public class NfcNdefCreateFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		Activity a = arg0.getActivity();
		NfcAdapter adapter = NfcAdapter.getDefaultAdapter(a);

		try {
			if (adapter == null) {
				return FREObject.newObject(false);
			}
		} catch (Exception e){}
		NfcNdefManager.getInstance().adapter = NfcAdapter.getDefaultAdapter(a);
		NfcNdefManager.getInstance().pIntent = PendingIntent.getActivity(a, 0,
                new Intent(a, a.getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0);

		IntentFilter ndefFilter = new IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED);
		try {ndefFilter.addDataType("text/plain");} catch (MalformedMimeTypeException mmte){}
		NfcNdefManager.getInstance().ndefFilters = new IntentFilter[]{ndefFilter};

		IntentFilter tagFilter = new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED);
		NfcNdefManager.getInstance().tagFilters = new IntentFilter[]{tagFilter};

		try {
			return FREObject.newObject(true);
		} catch (Exception e){
		}
		return null;
	}
}
