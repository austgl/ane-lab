package jp.itoz.ane.notification;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class NotificationExtention implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new NotificationContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
