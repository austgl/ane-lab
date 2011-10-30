package com.example.anelab.camera.bitmap.fre.extension;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * CameraDataColorReverseFREExtension
 * @author tokufxug
 * http://twitter.com/tokufxug
 */
public class CameraDataColorReverseFREExtension implements
	FREExtension {

	private FREContext cntxt;

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return getContext();
	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
	}

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
		// TODO 自動生成されたメソッド・スタブ

	}

	private FREContext getContext() {
		if (cntxt == null) {

			cntxt = new FREContext() {

				@Override
				public Map<String, FREFunction> getFunctions() {
					return getFuncs();
				}

				@Override
				public void dispose() {
				}
			};
		}
		return cntxt;
	}

	private Map<String, FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();
		funcs.put("reverse4Java", reverse());
		return funcs;
	}

	private FREFunction reverse() {

		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {

				FREBitmapData bmpData = null;
				FREObject ret = null;
				try {

					bmpData = (FREBitmapData) arg0.getActionScriptData();
					bmpData.acquire();
					final int max = bmpData.getWidth() * bmpData.getHeight();
					ByteBuffer bf = bmpData.getBits();
					int next = 0;

					while (next < max) {
						final int pos = bf.position();
						final int data = bf.getInt() ^ 0xffffffff;
						bf.putInt(pos, data);
						next++;
					}
					bmpData.release();

					arg0.setActionScriptData(bmpData);
					ret = FREObject.newObject("Java complete reverse!!");
				} catch (Throwable e) {
					try {
						ret = FREObject.newObject(e.toString());
					} catch (FREWrongThreadException ex) {}
				}
				return ret;
			}
		};
	}
}
