/**
 *
 */
package so.ane.tts.context;

import java.util.HashMap;
import java.util.Map;

import so.ane.tts.funcs.TTSCreateFREFunction;
import so.ane.tts.funcs.TTSShutdownFREFunction;
import so.ane.tts.funcs.TTSSpeakFREFunction;
import so.ane.tts.funcs.TTSStopFREFunction;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

/**
 * @author tokuyamasadao
 *
 */
public class TTSFREContext extends FREContext {

	public TTSFREContext() {
		super();
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREContext#dispose()
	 */
	@Override
	public void dispose() {
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREContext#getFunctions()
	 */
	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> funcs = new HashMap<String, FREFunction>();
		funcs.put("create", new TTSCreateFREFunction());
		funcs.put("speak", new TTSSpeakFREFunction());
		funcs.put("shutdown", new TTSShutdownFREFunction());
		funcs.put("stop", new TTSStopFREFunction());
		return funcs;
	}
}
