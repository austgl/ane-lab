package com.example.ane.mail;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * AneLabSendMailFREExtension
 * @author http://twitter.com/tokufxug
 */
public class AneLabSendMailFREExtension implements FREExtension {

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return getContext();
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
	}

	private FREContext _context;
	private FREContext getContext() {
		if (_context == null) {
			_context = new FREContext() {

				@Override
				public Map<String, FREFunction> getFunctions() {
					return getFuncs();
				}

				@Override
				public void dispose() {}
			};
		}
		return _context;
	}

	private Map<String, FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();
		funcs.put("send", send());
		return funcs;
	}

	private FREFunction send(){
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				FREObject result = null;
				try {
					AneLabGmailAccount account =
							getAccount(arg1[0]);

					AneLabSendMailObject mail =
							getMailObj(arg1[1]);

					String ret =
							AneLabSendMailMessage.getInstance().send(
									account, mail);
					result = FREObject.newObject(ret);

				} catch (Exception e) {
					try {
						result = FREObject.newObject(e.toString());
					} catch (FREWrongThreadException ex) {
					}
				}
				return result;
			}
		};
	}

	private AneLabGmailAccount getAccount(FREObject account) throws
		IllegalStateException, FRETypeMismatchException,
		FREInvalidObjectException, FREWrongThreadException,
		FREASErrorException, FRENoSuchNameException {

		AneLabGmailAccount gmail =
				new AneLabGmailAccount();
		// "account"
		gmail.setAccount(account.getProperty("account").getAsString());
		// "password"
		gmail.setPassword(account.getProperty("password").getAsString());

		return gmail;
	}

	private AneLabSendMailObject getMailObj(FREObject mail) throws
		IllegalStateException, FRETypeMismatchException,
		FREInvalidObjectException, FREWrongThreadException,
		FREASErrorException, FRENoSuchNameException {

		AneLabSendMailObject mailObj =
				new AneLabSendMailObject();
		// "subject"
		mailObj.setSubject(
				mail.getProperty("subject").getAsString());
		// "recipient"
		mailObj.setRecipient(
				mail.getProperty("recipient").getAsString());
		// "text"
		mailObj.setText(
				mail.getProperty("text").getAsString());

		return mailObj;
	}
}
