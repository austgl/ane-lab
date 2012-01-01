package so.ane.tts.funcs;

import so.ane.tts.speaker.TTSController;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class TTSShutdownFREFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		TTSController.getInstance().getTTS().shutdown();
		return null;
	}
}
