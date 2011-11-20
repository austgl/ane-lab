package com.example.ane.mail
{
	import flash.external.ExtensionContext;
	import flash.net.registerClassAlias;

	/**
	 * AneLabSendMailExtensionContext
	 * @author http://twitter.com/tokufxug
	 */
	public class AneLabSendMailExtensionContext
	{
		private var _context:ExtensionContext;

		public function AneLabSendMailExtensionContext()
		{
			readClass();
			_context = ExtensionContext.createExtensionContext("mail", "type");
		}

		public function send(account:AneLabGmailAccount,
			mail:AneLabSendMailObject):String {

			var ret:Object = _context.call("send", account, mail);
			if (!ret) {
				return "ok";
			} else {
				return ret as String;
			}
		}


		private function readClass():void {
			registerClassAlias(
				"com.example.ane.mail.AneLabGmailAccount",
				AneLabGmailAccount);
			registerClassAlias(
				"com.example.ane.mail.AneLabSendMailObject",
				AneLabSendMailObject);
		}
	}
}