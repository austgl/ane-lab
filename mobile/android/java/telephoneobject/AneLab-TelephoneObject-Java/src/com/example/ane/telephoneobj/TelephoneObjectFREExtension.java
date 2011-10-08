package com.example.ane.telephoneobj;

import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.telephony.TelephonyManager;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREReadOnlyException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * TelephoneObjectFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class TelephoneObjectFREExtension implements FREExtension {

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				FREFunction f = new FREFunction() {

					@Override
					public FREObject call(FREContext arg0, FREObject[] arg1) {


						return getTelephoneObject(arg0.getActivity());
					}
				};
				Map<String, FREFunction> ret = new HashMap<String, FREFunction>();
				ret.put("phone", f);
				return ret;
			}

			@Override
			public void dispose() {

			}
		};
	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
		// TODO 自動生成されたメソッド・スタブ

	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
		// TODO 自動生成されたメソッド・スタブ

	}

	private FREObject getTelephoneObject(Activity a) {

		TelephonyManager telMngr =
				(TelephonyManager) a.getSystemService(
						Activity.TELEPHONY_SERVICE);

		String call = "";
		switch (telMngr.getCallState()) {
			case TelephonyManager.CALL_STATE_IDLE:
				call = "通話可能状態";
				break;
			case TelephonyManager.CALL_STATE_OFFHOOK:
				call = "通話状態";
				break;
			case TelephonyManager.CALL_STATE_RINGING:
				call = "着信状態";
				break;
		}
		// データ（トラフィック） アクティブ 状況
		String active = "";
		switch (telMngr.getDataActivity()) {
			case TelephonyManager.DATA_ACTIVITY_DORMANT:
				active = "データ接続はアクティブ状況ですが、物理リンクはダウンしている";
				break;
			case TelephonyManager.DATA_ACTIVITY_IN:
				active = "受け取ったIP PPPトラフィック";
				break;
			case TelephonyManager.DATA_ACTIVITY_INOUT:
				active = "発送/受け取った IP PPPトラフィック";
				break;
			case TelephonyManager.DATA_ACTIVITY_NONE:
				active = "トラフィックなし";
				break;
			case TelephonyManager.DATA_ACTIVITY_OUT:
				active = "発送した IP PPPトラフィック";
				break;
		}
		String dataState = "";
		switch (telMngr.getDataState()) {
			case TelephonyManager.DATA_CONNECTED:
				dataState = "接続中";
				break;
			case TelephonyManager.DATA_CONNECTING:
				dataState = "接続完了";
				break;
			case TelephonyManager.DATA_DISCONNECTED:
				dataState = "未接続";
				break;
			case TelephonyManager.DATA_SUSPENDED:
				dataState = "一時中断";
				break;
		}
		String networkType = "";
		switch (telMngr.getNetworkType()) {
			case TelephonyManager.NETWORK_TYPE_1xRTT:
				networkType = "1xRTT";
				break;
			case TelephonyManager.NETWORK_TYPE_CDMA:
				networkType = "CDMA";
				break;
			case TelephonyManager.NETWORK_TYPE_EDGE:
				networkType = "EDGE";
				break;
			case TelephonyManager.NETWORK_TYPE_EVDO_0:
				networkType = "EVDO 0";
				break;
			case TelephonyManager.NETWORK_TYPE_EVDO_A:
				networkType = "EVDO A";
				break;
			case TelephonyManager.NETWORK_TYPE_GPRS:
				networkType = "GPRS";
				break;
			case TelephonyManager.NETWORK_TYPE_HSDPA:
				networkType = "HSDPA";
				break;
			case TelephonyManager.NETWORK_TYPE_HSPA:
				networkType = "HSPA";
				break;
			case TelephonyManager.NETWORK_TYPE_HSUPA:
				networkType = "HSUPA";
				break;
			case TelephonyManager.NETWORK_TYPE_IDEN:
				networkType = "IDEN";
				break;
			case TelephonyManager.NETWORK_TYPE_UMTS:
				networkType = "UMTS";
				break;
			case TelephonyManager.NETWORK_TYPE_UNKNOWN:
				networkType = "UNKNOWN";
				break;
		}
		String phoneType = "";
		switch (telMngr.getPhoneType()) {
			case TelephonyManager.PHONE_TYPE_CDMA:
				phoneType = "CDMA";
				break;
			case TelephonyManager.PHONE_TYPE_GSM:
				phoneType = "GSM";
				break;
			case TelephonyManager.PHONE_TYPE_NONE:
				phoneType = "NONE";
				break;
		}
		String simState = "";

		switch (telMngr.getSimState()) {
			case TelephonyManager.SIM_STATE_ABSENT:
				simState = "SIMカードなし";
				break;
			case TelephonyManager.SIM_STATE_NETWORK_LOCKED:
				simState = "SIMカードロック. 要：ネットワークPIN";
				break;
			case TelephonyManager.SIM_STATE_PIN_REQUIRED:
				simState = "SIMカードロック. 要：ユーザPIN";
				break;
			case TelephonyManager.SIM_STATE_PUK_REQUIRED:
				simState = "SIMカードロック. 要：ユーザPUN";
				break;
			case TelephonyManager.SIM_STATE_READY:
				simState = "SIMカード使用可";
				break;
			case TelephonyManager.SIM_STATE_UNKNOWN:
				simState = "UNKNOWN";
				break;
		}
		FREObject telObj = null;
		String error = "";
		try {
			telObj = FREObject.newObject("com.example.ane.telephoneobj.TelephoneObject", null);
			telObj.setProperty("callState", FREObject.newObject(call));
			telObj.setProperty("dataActivity", FREObject.newObject(active));
			telObj.setProperty("dataState", FREObject.newObject(dataState));
			telObj.setProperty("deviceId",
					FREObject.newObject(telMngr.getDeviceId()));
			telObj.setProperty("deviceSoftwareVersion",
					FREObject.newObject(telMngr.getDeviceSoftwareVersion()));
			telObj.setProperty("line1Number",
					FREObject.newObject(telMngr.getLine1Number()));
			telObj.setProperty("networkCountryIso",
					FREObject.newObject(telMngr.getNetworkCountryIso()));
			telObj.setProperty("networkOperator",
					FREObject.newObject(telMngr.getNetworkOperator()));
			telObj.setProperty("networkOperatorName",
					FREObject.newObject(telMngr.getNetworkOperatorName()));
			telObj.setProperty("networkType",
					FREObject.newObject(networkType));
			telObj.setProperty("phoneType",
					FREObject.newObject(phoneType));
			telObj.setProperty("simState",
					FREObject.newObject(simState));
			telObj.setProperty("simCountryIso",
					FREObject.newObject(
							telMngr.getSimCountryIso()));
			telObj.setProperty("simOperator",
					FREObject.newObject(
							telMngr.getSimOperator()));
			telObj.setProperty("simOperatorName",
					FREObject.newObject(
							telMngr.getSimOperatorName()));
			telObj.setProperty("simSerialNumber",
					FREObject.newObject(
							telMngr.getSimSerialNumber()));
			telObj.setProperty("subscriberId",
					FREObject.newObject(
							telMngr.getSubscriberId()));
			telObj.setProperty("voiceMailAlphaTag",
					FREObject.newObject(
							telMngr.getVoiceMailAlphaTag()));
			telObj.setProperty("voiceMailNumber",
					FREObject.newObject(
							telMngr.getVoiceMailNumber()));

		} catch (FREWrongThreadException e) {error = e.toString();
		} catch (FREReadOnlyException e) {error = e.toString();
		} catch (FRENoSuchNameException e) {error = e.toString();
		} catch (FREASErrorException e) {error = e.toString();
		} catch (FREInvalidObjectException e) {error = e.toString();
		} catch (FRETypeMismatchException e) {error = e.toString();
		}
		if (error != "") {
			try {
				telObj = FREObject.newObject(error);
			} catch (FREWrongThreadException e) {}
		}
		return telObj;
	}
}
