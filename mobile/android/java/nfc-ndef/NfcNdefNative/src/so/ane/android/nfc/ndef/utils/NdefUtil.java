package so.ane.android.nfc.ndef.utils;

import java.io.IOException;

import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.Ndef;
import android.nfc.tech.NdefFormatable;
import android.os.Parcelable;

@TargetApi(10)
public class NdefUtil {

	public static String WRITE_OK = "WRITE_OK";
	public static String WRITE_ERROR = "WRITE_ERROR";
	public static String WRITE_READ_ONLY = "WRITE_READ_ONLY";
	public static String WRITE_MAX_SIZE = "WRITE_MAX_SIZE";
	public static String WRITE_FAILED_FORMAT_TAG = "WRITE_FAILED_FORMAT_TAG";
	public static String WRITE_NOT_SUPPORT_NDEF = "WRITE_NOT_SUPPORT_NDEF";

	public static NdefMessage[] getMessage(Intent intent) {
		NdefMessage[] msg = null;
		String action = intent.getAction();

		boolean isTagORNdefAction =
			NfcAdapter.ACTION_TAG_DISCOVERED.equals(action) ||
			NfcAdapter.ACTION_NDEF_DISCOVERED.equals(action);

		if (!isTagORNdefAction) {
			return null;
		}

		Parcelable[] rawMsg = intent.getParcelableArrayExtra(
				NfcAdapter.EXTRA_NDEF_MESSAGES);
		if (rawMsg != null) {
			int length = rawMsg.length;
			msg = new NdefMessage[length];
			for (int i = 0; i < length; i++) {
				msg[i] = (NdefMessage) rawMsg[i];
			}
			return msg;
		}

		byte[] empty = new byte[]{};
		NdefRecord record  = new NdefRecord(NdefRecord.TNF_UNKNOWN, empty, empty, empty);
		NdefMessage nm = new NdefMessage(new NdefRecord[]{record});
		msg = new NdefMessage[]{nm};
		return msg;
	}

	public static  String getMessageBody(Intent intent) {
		NdefMessage[] msg = NdefUtil.getMessage(intent);
		byte[] payload = msg[0].getRecords()[0].getPayload();
		return new String(payload);
	}

	public static NdefMessage toNdefMessage(String s) {
		byte[] bytes = s.getBytes();

		NdefRecord record = new NdefRecord(
				NdefRecord.TNF_MIME_MEDIA, "text/plain".getBytes()
				,new byte[]{}
				, bytes);
		return new NdefMessage(new NdefRecord[]{record});
	}

	public static String writeMessage(String msg, Intent intent) {
		Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
		return write(toNdefMessage(msg), tag);
	}

	public static String write(NdefMessage msg, Tag tag) {
		try {
			Ndef ndef = Ndef.get(tag);
				if (ndef != null) {
					ndef.connect();

					if (!ndef.isWritable()) {
						return WRITE_READ_ONLY;
					}
					if (ndef.getMaxSize() < msg.toByteArray().length) {
						return WRITE_MAX_SIZE;
					}
					ndef.writeNdefMessage(msg);
					return WRITE_OK;
				} else {
					NdefFormatable format = NdefFormatable.get(tag);
					if (format != null) {
						try {
							format.connect();
							format.format(msg);
							return WRITE_OK;
						} catch (IOException e) {
							return WRITE_FAILED_FORMAT_TAG;
						}
					}
					return WRITE_NOT_SUPPORT_NDEF;
				}
		} catch (Exception e) {}
		return WRITE_ERROR;
	}
}
