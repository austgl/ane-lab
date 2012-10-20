package so.ane.android.nfc.foreground.dispatch;

import android.app.PendingIntent;
import android.content.Intent;
import android.nfc.NfcAdapter;

public class NFCManager {

	private static NFCManager mInstance;

	public NfcAdapter nfcAdapter;
	public Intent intent;
	public PendingIntent pendingIntent;

	public static synchronized NFCManager getInstance() {
		if (mInstance == null) {
			mInstance = new NFCManager();
		}
		return mInstance;
	}
}
