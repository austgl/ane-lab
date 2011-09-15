package com.example.ane.thread;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * ThreadFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class ThreadFREExtension implements FREExtension {

	private FREContext _c;

	private AddressTask _at;

	/* (�� Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String arg0) {
		// TODO �����������ꂽ���\�b�h�E�X�^�u
		return getContext();
	}

	/* (�� Javadoc)
	 * @see com.adobe.fre.FREExtension#dispose()
	 */
	@Override
	public void dispose() {
		// TODO �����������ꂽ���\�b�h�E�X�^�u

	}

	/* (�� Javadoc)
	 * @see com.adobe.fre.FREExtension#initialize()
	 */
	@Override
	public void initialize() {
		// TODO �����������ꂽ���\�b�h�E�X�^�u

	}

	private FREFunction getAddress() {
		return new FREFunction() {

			@Override
			public FREObject call(
					FREContext arg0, FREObject[] arg1) {

				FREObject ret = null;
				try {
					ret = FREObject.newObject("�Z���擾��");

					if (_at == null) {
						_at = new AddressTask(arg0);
					}
					_at.execute(arg1[0].getAsString());

				} catch (FREWrongThreadException e) {
				} catch (FREInvalidObjectException ex) {
				} catch (FRETypeMismatchException ex) {
				}
				return ret;
			}
		};
	}

	private FREFunction getData() {
		return new FREFunction() {

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				try {
					String ret = _at.data;
					_at = null;
					return FREObject.newObject(ret);
				} catch (FREWrongThreadException e) {

				}
				return null;
			}
		};
	}

	private Map<String,FREFunction> getFuncs() {
		Map<String, FREFunction> funcs =
				new HashMap<String, FREFunction>();

		funcs.put("address", getAddress());
		funcs.put("data", getData());
		return funcs;
	}

	private FREContext getContext() {
		if (_c != null) {
			return _c;
		}
		_c = new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				return getFuncs();
			}

			@Override
			public void dispose() {}
		};
		return _c;
	}
}
