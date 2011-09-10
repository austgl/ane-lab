package com.example.ane.android.helloworld;

import java.util.HashMap;
import java.util.Map;

import android.widget.Toast;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * HelloWorldFREExtension
 * @author @tokufxug http://twitter.com/tokufxug
 *
 */
public class HelloWorldFREExtension implements FREExtension {

	/* (非 Javadoc)
	 * @see com.adobe.fre.FREExtension#createContext(java.lang.String)
	 */
	@Override
	public FREContext createContext(String s) {
		FREContext c = new FREContext() {

			@Override
			public Map<String, FREFunction> getFunctions() {
				Map<String, FREFunction> funcs =
						new HashMap<String, FREFunction>();

				funcs.put("helloWorld", new FREFunction() {

					@Override
					public FREObject call(FREContext frecontext,
							FREObject[] afreobject) {

						String ret = "";
						FREObject retObj = null;

						try {
							String value =
								afreobject[0].getAsString();

							Toast.makeText(
									frecontext.getActivity(),
									value, Toast.LENGTH_LONG).show();

							ret = "call ->" + value;
						} catch (Exception e) {
							ret = e.toString();
						} finally {
							try {
								retObj = FREObject.newObject(ret);
							} catch (FREWrongThreadException e) {}
						}
						return retObj;
					};
				});
				return funcs;
			}

			@Override
			public void dispose() {
			}
		};
		return c;
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
}
