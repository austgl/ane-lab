package jp.itoz.ane.notification;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class NotificatioinFunction implements FREFunction {
	 
	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		
		
		String message = "";
		try {
			message = arg1[0].getAsString();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}
		
		String ns= Context.NOTIFICATION_SERVICE;
		NotificationManager notifManager = (NotificationManager) context.getActivity().getSystemService(ns);
		
		long when = System.currentTimeMillis();
		
		Notification notification = new Notification(context.getResourceId("drawable.notifyicon"),message,when);
					 notification.defaults |=Notification.DEFAULT_SOUND;
			
		CharSequence contentTitle ="Notification from Flash!";
		CharSequence contentText = message;
		
		Intent notificationIntent = new Intent();
		
		PendingIntent contentIntent = PendingIntent.getActivity(context.getActivity(), 0, notificationIntent, 0);
		
		notification.setLatestEventInfo(context.getActivity(), contentTitle, contentText, contentIntent);
		
		final int HELLO_ID=1;
		
		notifManager.notify(HELLO_ID,notification);
		
		return null;
	}

}
