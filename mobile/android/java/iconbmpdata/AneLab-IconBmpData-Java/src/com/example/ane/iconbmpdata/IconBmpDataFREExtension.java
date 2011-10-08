package com.example.ane.iconbmpdata;

import java.util.HashMap;
import java.util.Map;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * IconBmpDataFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class IconBmpDataFREExtension implements FREExtension {

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		return getContext();
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
	}

	private FREFunction getIconBmpData() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {

				try {
					final int icon = arg0.getResourceId("drawable.icon");

					Bitmap bmp = BitmapFactory.decodeResource(
							arg0.getActivity().getResources(),
							icon);

					if (!bmp.isMutable()) {
						bmp = bmp.copy(Bitmap.Config.ARGB_8888, true);
					}

					int width = bmp.getWidth();
					int height = bmp.getHeight();
					int[] pixels = new int[width * height];

					int hanten = (int) (Math.random() * 9999999) % 9999999;

					bmp.getPixels(pixels, 0, width, 0, 0, width, height);
					for (int y = 0; y < height; y++) {
						for (int x = 0; x < width; x++) {
							pixels[x + y * width] ^= (0x00ffffff ^ hanten);
						}
					}
					bmp.setPixels(pixels, 0, width, 0, 0, width, height);

					Byte[] fillcolor = {0, 0, 0, 0};

					FREBitmapData resImgData =
							FREBitmapData.newBitmapData(
									bmp.getWidth(), bmp.getHeight(),
									true, fillcolor);

					resImgData.acquire();
					bmp.copyPixelsToBuffer(resImgData.getBits());
					resImgData.release();

					return resImgData;
				} catch (FREWrongThreadException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FREInvalidObjectException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FREASErrorException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				}
				return null;
			}
		};
	}
	private Map<String,FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();

		funcs.put("iconBmpData", getIconBmpData());

		return funcs;
	}

	private FREContext getContext() {
		FREContext context = new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				return getFuncs();
			}

			@Override
			public void dispose() {}
		};
		return context;
	}
}
