//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2014 tokufxug (http://twitter.com/tokufxug | tokufxug@gmail.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////
package net.klaap.rolto
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;
	
	/**
	 * RoltoClipboardPrint
	 * <pre>
	 * URLスキームを利用して「Rolto - 画面をそのままプリント！」を
	 * 呼び出し印刷を行う。
	 * </pre>
	 * @author Sadao Tokuyama
	 */
	public class RoltoClipboardPrint
	{
		private var _ec:ExtensionContext;
		
		public function RoltoClipboardPrint()
		{
			_ec = ExtensionContext.createExtensionContext("net.klaap.rolto.RoltoClipboardPrint", null);
		}
		
		/**
		 * ロルトの使用有無の判定.<br>
		 * <pre>
		 *  動作条件：
		 *     「Rolto - 画面をそのままプリント！」がインストールしていること。
		 *  動作条件を満たしている場合、trueを返却。
		 *  動作条件を満たしていない場合、falseを返却。
		 * </pre>
		 * @return ロルト使用有無 Boolean
		 */
		public function isUseRolto():Boolean {
			return _ec.call("canUseRolto");
		}
		
		/**
		 * 印刷処理を行う.<br>
		 * <pre>
		 * • 印刷データについて… 
		 *    印刷データはBitmapDataのみ受け付ける。
		 *    iOS側のライブラリではUIImage型に変換を行っている。
		 *    （ロルトの印刷データフォーマットがUIImageであるため。）
		 * • 返却値について… 
		 *    「Rolto - 画面をそのままプリント！」が正常に起動した場合、trueを返却する。
		 *     上記以外は、falseを返却する。
		 *    「Rolto - 画面をそのままプリント！」からの印刷完了や印刷エラーなどの情報は
		 *     取得できない。
		 * </pre>
		 * @param data 印刷を行うデータ
		 * @return Roltoアプリ起動有無 Boolean
		 */
		public function print(data:BitmapData):Boolean {
			return _ec.call("print", data);
		}
		
		/**
		 * RoltoClipboardPrintを破棄します.<br>
		 * 内部のExtensionContextを破棄します。
		 */
		public function dispose():void {
		    _ec.dispose();
		}
	}
}