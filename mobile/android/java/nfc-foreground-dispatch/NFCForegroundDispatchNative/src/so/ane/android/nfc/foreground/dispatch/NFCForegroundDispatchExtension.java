package so.ane.android.nfc.foreground.dispatch;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class NFCForegroundDispatchExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new NFCForegroundDispatchContext();
	}

	@Override
	public void dispose() {

	}

	@Override
	public void initialize() {

	}
}
