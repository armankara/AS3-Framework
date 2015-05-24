package com.art.components 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class ImagePicker 
	{
		private var file:FileReference = new FileReference(); 
		private var loader:Loader = new Loader();
		private var onComplete:Function;
		
		public function ImagePicker(onComplete:Function = null) 
		{
			file.addEventListener(Event.SELECT, onSelect); 
			file.addEventListener(Event.COMPLETE, onFileComplete); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoad);
			this.onComplete = onComplete;
		}
		
		public function browse():void
		{
			file.browse([new FileFilter("Images", "*.jpg;*.jpeg;*.png")]);
		}
		
		private function onSelect(e:Event):void 
		{ 
			file.load();
		}
		
		private function onFileComplete(e:Event):void 
		{
			loader.loadBytes(e.target.data);
		}
		
		private function onImageLoad(e:Event):void
		{
			if (onComplete != null)
				onComplete(loader.content);
		}
	}
}