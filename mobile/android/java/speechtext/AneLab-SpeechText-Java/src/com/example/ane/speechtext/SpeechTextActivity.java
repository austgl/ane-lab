package com.example.ane.speechtext;

import java.util.List;
import java.util.Locale;

import com.adobe.fre.FREContext;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognizerIntent;


/**
 * SpeechTextActivity
 * @author @tokufxug http://twitter.com/tokufxug
 *
 */
public class SpeechTextActivity extends Activity {

	public static FREContext context;
	public static String message = "";
	private static final int REQUEST_CODE = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Intent intent = new Intent(
				RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
		intent.putExtra(
				RecognizerIntent.EXTRA_LANGUAGE_MODEL,
				RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
		intent.putExtra(
				RecognizerIntent.EXTRA_LANGUAGE, Locale.JAPAN.toString());

		intent.putExtra(
				RecognizerIntent.EXTRA_PROMPT, "Tweet!!");
		startActivityForResult(intent, REQUEST_CODE);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {

		switch (resultCode) {
			case RESULT_OK:
			case REQUEST_CODE:
				List<String> lst =
					data.getStringArrayListExtra(
							RecognizerIntent.EXTRA_RESULTS);
				message = lst.get(0);
				break;
		}
		super.onActivityResult(requestCode, resultCode, data);
		Intent intent = new Intent(this, context.getActivity().getClass());
		startActivity(intent);
	}
}
