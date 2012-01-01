/**
 *
 */
package so.ane.tts.funcs;

import so.ane.tts.speaker.TTSController;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * @author tokuyamasadao
 *
 */
public class TTSCreateFREFunction implements FREFunction {

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREFunction#call(com.adobe.fre.FREContext, com.adobe.fre.FREObject[])
	 */
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		TTSController.getInstance().createTTS(arg0);
		return null;
	}
}
