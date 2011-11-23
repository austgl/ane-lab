package com.example.nfc.idm;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREReadOnlyException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * AneLabNfcInfo
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class AneLabNfcInfo {

	private String idm;
	private String pmm;
	private String systemCode;

	public String getIdm() {
		return idm;
	}
	public void setIdm(String idm) {
		this.idm = idm;
	}
	public String getPmm() {
		return pmm;
	}
	public void setPmm(String pmm) {
		this.pmm = pmm;
	}
	public String getSystemCode() {
		return systemCode;
	}
	public void setSystemCode(String systemCode) {
		this.systemCode = systemCode;
	}

	public FREObject toFREObject() throws
		IllegalStateException, FRETypeMismatchException,
		FREInvalidObjectException, FREASErrorException,
		FRENoSuchNameException, FREWrongThreadException,
		FREReadOnlyException {

		FREObject o =
				FREObject.newObject("com.example.nfc.idm.AneLabNfcInfo",
				null);
		o.setProperty("idm", FREObject.newObject(idm));
		o.setProperty("pmm", FREObject.newObject(pmm));
		o.setProperty("systemCode", FREObject.newObject(systemCode));

		return o;
	}
}
