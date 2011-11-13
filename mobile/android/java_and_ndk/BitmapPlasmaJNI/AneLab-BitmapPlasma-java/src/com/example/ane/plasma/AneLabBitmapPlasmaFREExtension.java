package com.example.ane.plasma;

import java.util.HashMap;
import java.util.Map;

import android.graphics.Bitmap;
import android.widget.Toast;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREBitmapData;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * AneLabBitmapPlasmaFREExtension
 * @author http://twitter.com/tokufxug
 */
public class AneLabBitmapPlasmaFREExtension implements FREExtension {

	private FREContext _context = null;
	private Map<String, FREFunction> _funcs = null;


    /* (îÒ Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {

	}

	/* (îÒ Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String s) {
		if (_context == null) {
			_context = new FREContext() {

				@Override
				public Map<String, FREFunction> getFunctions() {
					if (_funcs == null) {
						_funcs = new HashMap<String, FREFunction>();
						_funcs.put("plasma", plasma());
					}
					return _funcs;
				}

				@Override
				public void dispose() {
				}
			};
		}
		return _context;
	}

	private FREFunction plasma() {
		return new FREFunction() {

			public FREObject call(FREContext frecontext, FREObject[] afreobject) {

				FREBitmapData ret = null;
				try {
					long start = System.currentTimeMillis() ;
					Bitmap img = getImage(frecontext);

					renderPlasma(img,
							System.currentTimeMillis() - start);
					ret = toFREBitmapData(img);
				} catch (Exception e) {
					Toast.makeText(frecontext.getActivity(), e.toString()
							, Toast.LENGTH_LONG).show();
				}
				return ret;
			}

			/* Image */
			private Bitmap getImage(FREContext frecontext) {
				return Bitmap.createBitmap(640, 480, Bitmap.Config.RGB_565);
			}

			/* Bitmap Å® FREBitmapData */
			private FREBitmapData toFREBitmapData(Bitmap bitmap) throws
				  IllegalArgumentException, FREASErrorException
				, FREWrongThreadException, IllegalStateException
				, FREInvalidObjectException {

				Byte[] fillcolor = {0, 0, 0, 0};

				FREBitmapData ret =
						FREBitmapData.newBitmapData(
								bitmap.getWidth(), bitmap.getHeight(),
								true, fillcolor);

				ret.acquire();
				bitmap.copyPixelsToBuffer(ret.getBits());
				ret.release();

				return ret;
			}
		};
	}

	/* (îÒ Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {

	}

	/* load our native library */
    static {
       System.loadLibrary("plasma");
    }

	/* implementend by libplasma.so */
	private static native void renderPlasma(Bitmap  bitmap, long time_ms);

}
