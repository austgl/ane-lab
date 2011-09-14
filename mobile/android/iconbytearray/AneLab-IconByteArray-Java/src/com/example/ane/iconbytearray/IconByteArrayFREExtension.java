package com.example.ane.iconbytearray;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Bitmap.CompressFormat;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREByteArray;
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
 * IconByteArrayFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class IconByteArrayFREExtension implements FREExtension {

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

	private FREFunction getIconByteArray() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {

				try {
					final int icon = arg0.getResourceId("drawable.icon");

					Bitmap bmp = BitmapFactory.decodeResource(
							arg0.getActivity().getResources(),
							icon);

					ByteArrayOutputStream os= new ByteArrayOutputStream();
			        bmp.compress(CompressFormat.PNG, 100 ,os);
			        byte[] b = os.toByteArray();

					FREByteArray ba = FREByteArray.newByteArray();
					ba.setProperty("length", FREObject.newObject(b.length));

					ba.acquire();
					ByteBuffer bf = ba.getBytes();
					bf.put(b);
					ba.release();

					return ba;
				} catch (FREWrongThreadException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FREInvalidObjectException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FREASErrorException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FREReadOnlyException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FRENoSuchNameException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				} catch (FRETypeMismatchException e) {
					try {return FREObject.newObject(e.toString());} catch (FREWrongThreadException ex) {}
				}
				return null;
			}
		};
	}
	private Map<String,FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();

		funcs.put("iconByteArray", getIconByteArray());

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
