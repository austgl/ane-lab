package jp.itoz.ane.notification;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class NotificationContext extends FREContext {

	@Override
	public void dispose() {
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> map= new HashMap<String, FREFunction>();
		map.put("notify",new NotificatioinFunction());
		return map;
	}

}
