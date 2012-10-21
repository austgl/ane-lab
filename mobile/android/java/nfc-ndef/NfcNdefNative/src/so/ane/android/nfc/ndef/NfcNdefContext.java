package so.ane.android.nfc.ndef;

import java.util.HashMap;
import java.util.Map;

import so.ane.android.nfc.ndef.function.NfcNdefCreateFunction;
import so.ane.android.nfc.ndef.function.NfcNdefExchangeFunction;
import so.ane.android.nfc.ndef.function.NfcNdefPauseFunction;
import so.ane.android.nfc.ndef.function.NfcNdefResumeFunction;
import so.ane.android.nfc.ndef.function.NfcNdefWriteFunction;
import so.ane.android.nfc.ndef.function.NfcNdefWriteModeFunction;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class NfcNdefContext extends FREContext {

	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> funcs = new HashMap<String, FREFunction>();
		funcs.put("create", new NfcNdefCreateFunction());
		funcs.put("resume", new NfcNdefResumeFunction());
		funcs.put("pause", new NfcNdefPauseFunction());
		funcs.put("writeMode", new NfcNdefWriteModeFunction());
		funcs.put("exchange", new NfcNdefExchangeFunction());
		funcs.put("write", new NfcNdefWriteFunction());
		return funcs;
	}
}
