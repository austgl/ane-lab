package com.example.ane.nfc.fre.extension;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;
import android.nfc.NfcAdapter;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * NFCFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class NFCFREExtension implements FREExtension {

	NfcAdapter nfcAdapter = null;

	/*
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return getContext();
	}

	/*
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {

	}

	/*
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {

	}

	private FREContext getContext() {
		return new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				return getFuncs();
			}

			@Override
			public void dispose() {

			}
		};
	}

	private Map<String, FREFunction> getFuncs() {
		Map<String, FREFunction> funcs = new HashMap<String, FREFunction>();
		funcs.put("info", getInfoFunc());
		return funcs;
	}

	private FREFunction getInfoFunc() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				Intent intent = arg0.getActivity().getIntent();
				String action = intent.getAction();
				String ret = "ACTION => " + action + "\n";

				if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(action)) {
					byte b[] = intent.getByteArrayExtra(NfcAdapter.EXTRA_ID);
					for (int i = 0; i < b.length; i++) {
						ret += Integer.toHexString(b[i]) + "\n";
					}
				}

				FREObject freObj = null;
				try {
					freObj = FREObject.newObject(ret);
				} catch (FREWrongThreadException e) {}
				return freObj;
			}
		};
	}
}
