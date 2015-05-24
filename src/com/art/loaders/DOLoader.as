package com.art.loaders 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author Arman Kara
	 */	
	public class DOLoader extends Loader
	{	
		protected var _url:String;
		protected var _complete:Function;
		protected var _error:Function;
		protected var _progress:Function;
		protected var _status:Function;
		protected var _loadPercent:Number;
		
		override public function load(request:URLRequest, context:LoaderContext = null):void 
		{
			throw new Error("Use Load(url:String, complete:Function = null, error:Function = null, progress:Function = null, status:Function = null):void method");
		}
		
		public function Load(url:String, complete:Function = null, error:Function = null, progress:Function = null, status:Function = null):void
		{
			_url = url;
			
			if (complete != null)
			{
				_complete = complete;
				contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			}
			
			if (error != null)
			{
				_error = error;
				contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			}
			
			if (progress != null)
			{
				_progress = progress;
				contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			}
			
			if (status != null)
			{
				_status = status;
				contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			}
			
			super.load(new URLRequest(_url), new LoaderContext(true));
		}
		
		public function Destroy():void
		{
			_url = null;
			_loadPercent = NaN;
			
			if (_complete != null)
			{
				contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				_complete = null;
			}
			
			if (_error != null)
			{
				contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				_error = null;
			}
			
			if (_progress != null)
			{
				contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				_progress = null;
			}
			
			if (_status != null)
			{
				contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
				_status = null;
			}
		}
		
		protected function onComplete(e:Event):void
		{
			_complete();
		}
		
		protected function onError(e:IOErrorEvent):void
		{
			_error();
		}
		
		protected function onProgress(e:ProgressEvent):void
		{
			_loadPercent = (e.bytesLoaded / e.bytesTotal);
			_progress();
		}
		
		protected function onHTTPStatus(e:HTTPStatusEvent):void
		{
			_status();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get loadPercent():Number
		{
			return _loadPercent;
		}
		
		public function get bitmapData():BitmapData
		{
			var bmp:BitmapData;
			if (content)
			{
				bmp = new BitmapData(content.width, content.height);
				bmp.draw(content);
			}
			return bmp;
		}
	}
}