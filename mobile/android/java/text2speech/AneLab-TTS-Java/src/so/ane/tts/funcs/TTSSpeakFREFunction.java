package so.ane.tts.funcs;

import so.ane.tts.speaker.TTSController;
import android.speech.tts.TextToSpeech;
import android.widget.Toast;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class TTSSpeakFREFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		try {
			String text = arg1[0].getAsString();
			Float pitch = new Float(arg1[1].getAsDouble());
			Float speechRate = new Float(arg1[2].getAsDouble());

			TextToSpeech tts = TTSController.getInstance().getTTS();
			tts.setPitch(pitch);
			tts.setSpeechRate(speechRate);
			TTSController.getInstance().speak(text);

		} catch (Exception e) {
			Toast.makeText(arg0.getActivity(), "ÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇΩ", Toast.LENGTH_LONG).show();
		}
		return null;
	}
}
