package com.art.display 
{
	import com.art.lib.Get;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class AMovieClip extends MovieClip
	{
		public static const WHITE:uint = 0xFFFFFF;
		public static const BLACK:uint = 0x000000;
		
		public function ASprite() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		protected function onRemove(e:Event = null):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, onUpdate);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function onUpdate(e:Event = null):void 
		{
			
		}
		
		public function DrawBackground(color:uint = BLACK, alpha:Number = 1):void
		{
			if (stage)
			{
				graphics.clear();
				graphics.beginFill(color, alpha);
				graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				graphics.endFill();
			}
			else
				Get.Log("ASprite::DrawBackground : There's no stage !");
		}
		
		public function GetCenterPoint(child:DisplayObject):Point
		{
			var point:Point = new Point();
			if (stage)
			{
				point.x = (stage.stageWidth - child.width) / 2;
				point.y = (stage.stageHeight - child.height) / 2;
			}
			else
				Get.Log("ASprite::GetCenterPoint : There's no stage !");
			return point;
		}
		
		public function MoveCenter(child:DisplayObject):void
		{
			var pnt:Point = GetCenterPoint(child);
			child.x = pnt.x;
			child.y = pnt.y;
		}
		
		public function get childs():Array
		{
			var childs:Array = [];
			for (var i:int = 0; i < numChildren; i++)
				childs.push(getChildAt(i));
			return childs;
		}
	}
}