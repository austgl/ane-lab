package so.ane.android.nfc.foreground.dispatch;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class NFCForegroundDispatchContext extends FREContext {

	public static String NFC_FOREGROUND_DISPATCH_INTENT_KEY
		= "NFC_FOREGROUND_DISPATCH__INTENT_KEY";

	public static String NFC_FOREGROUND_DISPATCH_INTENT_VALUE
		= "NFC_FOREGROUND_DISPATCH__INTENT_VALUE";

	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> mf = new HashMap<String, FREFunction>();
		mf.put("create", new CreateFunction());
		mf.put("pause", new PauseFunction());
		mf.put("resume", new ResumeFunction());
		mf.put("newIntent", new NewIntentFunction());
		return mf;
	}
}
