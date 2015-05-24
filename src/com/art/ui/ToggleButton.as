package com.art.ui 
{
	import flash.events.MouseEvent;
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class ToggleButton extends BaseButton 
	{
		private var _pressed:Boolean = false;
		private var func:Function;
		
		public function ToggleButton() 
		{
			
		}
		
		override protected function MClick(e:MouseEvent):void 
		{
			super.MClick(e);
			pressed = !pressed;
			func(pressed);
		}
		
		public function Click(func:Function):void
		{
			this.func = func;
		}
		
		public function get pressed():Boolean 
		{
			return _pressed;
		}
		
		public function set pressed(value:Boolean):void 
		{
			_pressed = value;
			
			if (value)
			{
				gotoAndStop(2);
			}
			else
			{
				gotoAndStop(1);
			}
		}
		
	}

}