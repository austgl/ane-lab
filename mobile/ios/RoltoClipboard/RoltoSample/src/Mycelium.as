package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class Mycelium extends Sprite
	{
		public var canvas:BitmapData;
		private var loader:Loader;
		private var line:Shape;
		
		public function Mycelium(){
			// init
			loader = new Loader;
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, init);
			loader.load (new URLRequest ("http://www.ht.sfc.keio.ac.jp/~takuro/blog/files/lena.png"),
				new LoaderContext (true));
		}
		
		public function init (e:Event):void {
			if (canvas == null) {
				canvas = loader.content["bitmapData"];
				canvas = resize(canvas, 0.8, 0.8);
				addChild(new Bitmap(canvas,"auto",true));  
			}
		}
		
		public function draw(ox:Number, oy:Number, lx:Number, ly:Number):void {
			
			//line.graphics.lineStyle(1.0, 0x000000, 1.0);
			//line.graphics.moveTo(bgn.x, bgn.y);
			//line.graphics.lineTo(end.x, end.y);
			
			drawLine(canvas, ox, oy, lx, ly);
		}
		
		public function resize(src:BitmapData, hRatio:Number, vRatio:Number):BitmapData
		{
			var res:BitmapData = new BitmapData(
				Math.ceil(src.width * hRatio), Math.ceil(src.height * vRatio)
			);
			res.draw(src, new Matrix(hRatio, 0, 0, vRatio), null, null, null, true);
			return res;
		}
		
	    public function drawLine(bmpDt:BitmapData, x1:Number, y1:Number, x2:Number, y2:Number, Color:Number = 0x000000):void
		{
			var	addX:Number, addY:Number;
			var	counter:Number = 0;
			var i:Number;
			
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			
			if (dx < 0) {
				addX = -1;
				dx = -dx;
			} else {
				addX = 1;
			}
			if (dy < 0) {
				addY = -1;
				dy = -dy;
			} else {
				addY = 1;
			}
			
			// 描画開始位置
			var x:Number = x1;
			var y:Number = y1;
			if (dx >= dy) {
				for (i = 0; i < dx; i++) {
					
					for (var k:int = 0; k < 7; k++) {
						for (var k2:int = 0; k2 < 7; k2++) {
							bmpDt.setPixel(x + k, y + k2, Color);
						}
					}
					
					x += addX;
					counter += dy;
					if (counter >= dx) {
						y += addY;
						counter -= dx;
					}
				}
			} else {
				for (i = 0; i < dy; i++) {
					
					for (var k:int = 0; k < 7; k++) {
						for (var k2:int = 0; k2 < 7; k2++) {
							bmpDt.setPixel(x + k, y + k2, Color);
						}
					}
					
					y += addY;
					counter += dx;
					if (counter >= dy) {
						x += addX;
						counter -= dy;
					}
				}
			}
		}
	}
}