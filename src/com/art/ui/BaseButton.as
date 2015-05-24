package com.art.ui
{
	import com.art.display.AMovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class BaseButton extends AMovieClip
	{
		public function BaseButton() 
		{
			stop();
			buttonMode = true;
		}
		
		override protected function init(e:Event = null):void 
		{
			super.init(e);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.CLICK, MClick);
			addEventListener(MouseEvent.MOUSE_OVER, MROver);
			addEventListener(MouseEvent.MOUSE_OUT, MROut);
			addEventListener(MouseEvent.MOUSE_DOWN, MDown);
			addEventListener(MouseEvent.MOUSE_UP, MUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MSDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, MSUp);
		}
		
		override protected function onRemove(e:Event = null):void 
		{
			super.onRemove(e);
			removeEventListener(MouseEvent.CLICK, MClick);
			removeEventListener(MouseEvent.MOUSE_OVER, MROver);
			removeEventListener(MouseEvent.MOUSE_OUT, MROut);
			removeEventListener(MouseEvent.MOUSE_DOWN, MDown);
			removeEventListener(MouseEvent.MOUSE_UP, MUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, MSDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, MSUp);
		}
		
		protected function MClick(e:MouseEvent):void 
		{
			
		}
		
		protected function MROver(e:MouseEvent):void 
		{
			
		}
		
		protected function MROut(e:MouseEvent):void 
		{
			
		}
		
		protected function MDown(e:MouseEvent):void 
		{
			
		}
		
		protected function MUp(e:MouseEvent):void 
		{
			
		}
		
		protected function MSDown(e:MouseEvent):void 
		{
			
		}
		
		protected function MSUp(e:MouseEvent):void 
		{
			
		}
		
	}

}