package com.art.ui.scroll 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class VScrollBar 
	{
		private var _stage:Stage;
		private var content:DisplayObject;
		private var contentMask:DisplayObject;
		private var scroll:Sprite;
		private var scrollBar:DisplayObject;
		private var tDown:Boolean;
		
		public function VScrollBar(_stage:Stage, content:DisplayObject, contentMask:DisplayObject, scroll:Sprite, scrollBar:DisplayObject) 
		{
			this._stage = _stage;
			this.content = content;
			this.contentMask = contentMask;
			this.scroll = scroll;
			this.scrollBar = scrollBar;
			content.mask = contentMask;
			scroll.y = scrollBar.y;
			scroll.buttonMode = true;
			scroll.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			tDown = true;
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (tDown)
			{
				scroll.y = scroll.parent.mouseY;
				
				var scrollYAble:Number = (scrollBar.y + scrollBar.height - scroll.height);
				
				if (scroll.y < scrollBar.y)
					scroll.y = scrollBar.y;
				if (scroll.y > scrollYAble)
					scroll.y = scrollYAble;
				
				var dif:Number = Math.abs(scrollBar.y - scroll.y);
				var perc:Number = (dif /  (scrollBar.height - scroll.height));
				TweenMax.to(content, .3, { y: contentMask.y  - ((content.height - contentMask.height) * perc) } );
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			tDown = false;
		}
	}
}