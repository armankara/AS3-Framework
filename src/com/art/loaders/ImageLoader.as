package com.art.loaders 
{
	import flash.display.Bitmap;
	import flash.events.Event;

	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class ImageLoader extends DOLoader 
	{
		override protected function onComplete(e:Event):void 
		{
			var bmp:Bitmap = Bitmap(content);
			if (bmp)
				bmp.smoothing = true;
			super.onComplete(e);
		}
	}
}