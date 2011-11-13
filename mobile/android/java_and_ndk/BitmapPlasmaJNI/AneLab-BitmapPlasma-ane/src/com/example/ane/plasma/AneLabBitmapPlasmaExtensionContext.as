package com.example.ane.plasma
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;

	public class AneLabBitmapPlasmaExtensionContext
	{
		private var _context:ExtensionContext;

		public function AneLabBitmapPlasmaExtensionContext()
		{
			_context = ExtensionContext.createExtensionContext("plasma", "type");
		}

		public function plasma():Object {
			return _context.call("plasma");
		}
	}
}