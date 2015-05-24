package com.art.loaders 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class ULoader extends URLLoader 
	{
		protected var _url:String;
		protected var _complete:Function;
		protected var _error:Function;
		protected var _progress:Function;
		protected var _status:Function;
		protected var _loadPercent:Number;
		
		override public function load(request:URLRequest):void 
		{
			throw new Error("Use Load(url:String, complete:Function = null, error:Function = null, progress:Function = null, status:Function = null):void method");
		}
		
		public function Load(url:String, complete:Function = null, error:Function = null, progress:Function = null, status:Function = null):void
		{
			_url = url;
			
			if (complete != null)
			{
				_complete = complete;
				addEventListener(Event.COMPLETE, onComplete);
			}
			
			if (error != null)
			{
				_error = error;
				addEventListener(IOErrorEvent.IO_ERROR, onError);
			}
			
			if (_progress != null)
			{
				_progress = progress;
				addEventListener(ProgressEvent.PROGRESS, onProgress);
			}
			
			if (status != null)
			{
				_status = status;
				addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			}
			
			super.load(new URLRequest(_url));
		}
		
		public function Destroy():void
		{
			_url = null;
			_loadPercent = NaN;
			
			if (_complete != null)
			{
				removeEventListener(Event.COMPLETE, onComplete);
				_complete = null;
			}
			
			if (_error != null)
			{
				removeEventListener(IOErrorEvent.IO_ERROR, onError);
				_error = null;
			}
			
			if (_progress != null)
			{
				removeEventListener(ProgressEvent.PROGRESS, onProgress);
				_progress = null;
			}
			
			if (_status != null)
			{
				removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
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
	}
}