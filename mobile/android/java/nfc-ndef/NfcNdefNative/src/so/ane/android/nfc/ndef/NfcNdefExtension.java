package so.ane.android.nfc.ndef;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class NfcNdefExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new NfcNdefContext();
	}

	@Override
	public void dispose() {

	}

	@Override
	public void initialize() {

	}
}
