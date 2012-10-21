package so.ane.android.nfc.ndef;

import so.ane.android.nfc.ndef.utils.NdefUtil;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.IntentFilter;
import android.nfc.NfcAdapter;

@TargetApi(10)
public class NfcNdefManager {

	private static NfcNdefManager instance;
	public NfcAdapter adapter;
	public PendingIntent pIntent;
	public IntentFilter[] tagFilters;
	public IntentFilter[] ndefFilters;

	private NfcNdefManager() {
		super();
	}

	public static synchronized NfcNdefManager getInstance() {
		if (instance == null) {
			instance = new NfcNdefManager();
		}
		return instance;
	}

	public void enableNdefExchangeMode(Activity a, String msg) {
			adapter.enableForegroundNdefPush(a, NdefUtil.toNdefMessage(msg));
			adapter.enableForegroundDispatch(a, pIntent, ndefFilters, null);
	}

	public void enableTagWriteMode(Activity a) {
	        IntentFilter tagDetected = new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED);
	        tagFilters = new IntentFilter[] {
	            tagDetected
	        };
	        adapter.enableForegroundDispatch(a, pIntent, tagFilters, null);
	}
}
