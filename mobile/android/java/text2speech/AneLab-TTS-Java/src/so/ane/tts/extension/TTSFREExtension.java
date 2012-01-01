/**
 *
 */
package so.ane.tts.extension;

import so.ane.tts.context.TTSFREContext;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * @author tokuyamasadao
 *
 */
public class TTSFREExtension implements FREExtension {

	private TTSFREContext _context;

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		if (_context == null) {
			_context = new TTSFREContext();
		}
		return _context;
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
		if (_context != null) {
			_context.dispose();
			_context = null;
		}
	}

	/* (”ñ Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {

	}
}
