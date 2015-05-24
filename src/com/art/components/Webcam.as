package com.art.components 
{
	import com.art.display.ASprite;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class Webcam extends ASprite 
	{
		
		private var video:Video;
		private var vidMatrix:Matrix;
		private var camera:Camera;
		private var bd:BitmapData;
		private var _mirorX:Boolean = false;
		
		public function Webcam() 
		{
			camera = Camera.getCamera();
			camera.setMode(640, 480, 60);
			camera.setQuality(0, 100);
			video = new Video(640, 480);
			video.smoothing = true;
			vidMatrix = new Matrix();
			addChild(video);
			bd = new BitmapData(video.width, video.height);
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			video.attachCamera(camera);
		}
		
		override protected function onRemove(e:Event):void 
		{
			super.onRemove(e);
			video.attachCamera(null);
		}
		
		public function takePhoto():BitmapData
		{
			bd.fillRect(bd.rect, 0);
			vidMatrix.a = video.scaleX;
			vidMatrix.d = video.scaleY;
			vidMatrix.tx = video.x;
			vidMatrix.ty = video.y;
			bd.draw(video, vidMatrix);
			return bd;
		}
		
		public function get mirorX():Boolean 
		{
			return _mirorX;
		}
		
		public function set mirorX(value:Boolean):void 
		{
			_mirorX = value;
			
			if (value)
			{
				video.scaleX = -1;
				video.x = video.width;
			}
			else
			{
				video.scaleX = 1;
				video.x = 0;
			}
		}
		
	}

}