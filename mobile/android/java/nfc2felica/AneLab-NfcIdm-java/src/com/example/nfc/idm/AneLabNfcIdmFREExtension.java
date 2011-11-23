package com.example.nfc.idm;

import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.content.Intent;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.NfcF;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * AneLabNfcIdmFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class AneLabNfcIdmFREExtension implements FREExtension {

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				Map<String, FREFunction> funcs =
						new HashMap<String, FREFunction>();
				funcs.put("readIdm", readIdm());
				return funcs;
			}

			@Override
			public void dispose() {

			}
		};
	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
		// TODO 自動生成されたメソッド・スタブ

	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
		// TODO 自動生成されたメソッド・スタブ

	}

	private FREFunction readIdm() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				FREObject ret = null;
				try {

					Activity a = arg0.getActivity();
					Intent intent = a.getIntent();

					Tag tag = (Tag)
							intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
					NfcF techF = NfcF.get(tag);

					byte[] idm = intent.getByteArrayExtra(NfcAdapter.EXTRA_ID);
					byte[] pmm = techF.getManufacturer();
			    	byte[] systemCode = techF.getSystemCode();

			    	AneLabNfcInfo info = new AneLabNfcInfo();
			    	info.setIdm(toByteDataString(idm));
			    	info.setPmm(toByteDataString(pmm));
			    	info.setSystemCode(toByteDataString(systemCode));
			    	ret = info.toFREObject();
				} catch (Exception e) {
					try {
						ret = FREObject.newObject(e.toString());
					} catch (FREWrongThreadException ex){}
				}
				return ret;
			}
		};
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
