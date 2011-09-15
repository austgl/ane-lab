package com.example.ane.thread;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import com.adobe.fre.FREContext;

import android.location.Address;
import android.location.Geocoder;
import android.os.AsyncTask;

/**
 * AddressTask
 * @author @tokufxug http://twitter.com/tokufxug
 */
public class AddressTask extends AsyncTask<String, Integer, Address> {

	public String data = "";
	private FREContext _f = null;
	private Geocoder _geo = null;

	public AddressTask(FREContext f) {
		_f = f;
		_geo = new Geocoder(f.getActivity(), Locale.getDefault());
	}

	@Override
	protected Address doInBackground(String... params) {
		Address result = null;
		try {
			List<Address> results =
					_geo.getFromLocationName(
							params[0], 1);

			if (results != null && !results.isEmpty()) {
				result = results.get(0);
			}
		} catch (IOException e) {}
		return result;
	}

	@Override
	protected void onPostExecute(Address result) {

		String code = "OK";
		String level = "0";
		if (result != null) {
			double latitude = result.getLatitude();
			double longitude = result.getLongitude();

			StringBuilder builder = new StringBuilder();
			builder.append("latitude:").append(String.valueOf(latitude)).append("\n");
			builder.append("longitude:").append(String.valueOf(longitude));
			data = builder.toString();
		} else {
			data = "ë∂ç›ÇµÇ‹ÇπÇÒ";
		}
		_f.dispatchStatusEventAsync(code, level);
	}
}
