package market.android.anelab;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

/**
 * AneLabBillingReceiverService
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class AneLabBillingReceiverService extends Service {

	public static BillingService marketService;

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		marketService.handleCommand(intent, startId);
        return START_NOT_STICKY;
	}
}
