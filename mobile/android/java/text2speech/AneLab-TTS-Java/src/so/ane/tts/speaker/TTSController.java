package so.ane.tts.speaker;

import java.util.HashMap;
import java.util.Locale;

import com.adobe.fre.FREContext;

import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.speech.tts.TextToSpeech.OnUtteranceCompletedListener;

public class TTSController implements OnInitListener, OnUtteranceCompletedListener {

	private static final String END_OF_WAKEUP_MESSAGE_ID = "end of wakeup message ID";
	private static TTSController _instance;
	private TextToSpeech _tts;
	private FREContext _freContext;
	private HashMap<String, String> _alarmParam;

	public static TTSController getInstance() {
		if (_instance == null) {
			_instance = new TTSController();
		}
		return _instance;
	}

	public void createTTS(FREContext context) {
		if (_tts == null) {
			_tts = new TextToSpeech(
					context.getActivity(), this);
			_alarmParam = new HashMap<String, String>();
			_alarmParam.put(TextToSpeech.Engine.KEY_PARAM_UTTERANCE_ID,
					END_OF_WAKEUP_MESSAGE_ID);
		}
		_freContext = context;
	}

	public void speak(String text) {
		_tts.speak(text, TextToSpeech.QUEUE_FLUSH, _alarmParam);
	}

	public TextToSpeech getTTS() {
		return _tts;
	}

	@Override
	public void onInit(int status) {
		String ttsStatus = "ERROR";
		switch (status) {
			case TextToSpeech.SUCCESS:
				_tts.setLanguage(Locale.getDefault());
				ttsStatus = "SUCCESS";
				break;
		}
		_tts.setOnUtteranceCompletedListener(this);
		_freContext.dispatchStatusEventAsync("CREATE_STATUS", ttsStatus);
	}

	@Override
	public void onUtteranceCompleted(String utteranceId) {
		if (END_OF_WAKEUP_MESSAGE_ID.equals(utteranceId)) {
			_freContext.dispatchStatusEventAsync("PLAY_STATUS", "COMPLETED");
		}
	}
}
