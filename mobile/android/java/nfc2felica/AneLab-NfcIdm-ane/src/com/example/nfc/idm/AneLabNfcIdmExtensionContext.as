package com.example.nfc.idm
{
	import flash.external.ExtensionContext;
	import flash.net.registerClassAlias;

	public class AneLabNfcIdmExtensionContext
	{
		private var _context:ExtensionContext;

		public function AneLabNfcIdmExtensionContext()
		{
			readClass();
			_context = ExtensionContext.createExtensionContext("nfc", "type");
		}

		public function readIdm():Object {
			return _context.call("readIdm");
		}

		private function readClass():void {
			registerClassAlias("com.example.nfc.idm.AneLabNfcInfo", AneLabNfcInfo);
		}
	}
}