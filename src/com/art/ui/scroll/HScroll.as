package com.art.ui.scroll 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class HScroll
	{
		private var _stage:Stage;
		private var back:Sprite;
		private var scroll:Sprite;
		private var tDown:Boolean;
		private var onScrollChange:Function;
		
		public function HScroll(_stage:Stage, back:Sprite, scroll:Sprite, onScrollChange:Function = null) 
		{
			this._stage = _stage;
			this.back = back;
			this.scroll = scroll;
			this.onScrollChange = onScrollChange;
			
			scroll.y = 0;
			scroll.buttonMode = true;
			scroll.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			ScrollPercent = 1;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			tDown = true;
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (tDown)
			{
				scroll.x = scroll.parent.mouseX;
				
				var scrollXAble:Number = (back.x + back.width - scroll.width / 2);
				
				if (scroll.x < back.x + scroll.width / 2)
					scroll.x = back.x + scroll.width / 2;
				if (scroll.x > scrollXAble)
					scroll.x = scrollXAble;
				
				dispatchCallback();
			}
		}
		
		public function set ScrollPercent(value:Number):void
		{
			value = Math.min(value, 1);
			value = Math.max(value, 0);
			scroll.x = (value * (back.x + back.width - scroll.width));
			dispatchCallback();
		}
		
		public function get ScrollPercent():Number
		{
			return (scroll.x) / (back.x + back.width - scroll.width);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			tDown = false;
		}
		
		private function dispatchCallback():void
		{
			if (onScrollChange != null)
			{
				onScrollChange(ScrollPercent);
			}
		}
	}
}