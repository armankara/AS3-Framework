package com.art.components 
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.serialization.json.JSON;
	import com.art.lib.Get;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class Uploader 
	{
		private var request:URLRequest; 
		private var onComplete:Function;
		private var loader:URLLoader;
		
		public function Uploader(uploadURL:String, onComplete:Function = null) 
		{			
			this.onComplete = onComplete;
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, completeHandler);
			request = new URLRequest(uploadURL);
			request.requestHeaders.push(new URLRequestHeader('Cache-Control', 'no-cache'));
			request.method = URLRequestMethod.POST;
		}
		
		public function upload(bmp:BitmapData):void
		{
			request.contentType = 'multipart/form-data; boundary=' + UploadPostHelper.getBoundary();
			request.data = UploadPostHelper.getPostData("image.jpg", new JPGEncoder(85).encode(bmp));
			loader.load(request);
		}
		
		private function completeHandler(e:Event):void 
		{
			if (onComplete != null)
				onComplete(e.target.data);
		}
	}
}