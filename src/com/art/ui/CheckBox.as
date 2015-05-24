package com.art.ui 
{
	import com.art.ui.BaseButton;
	import flash.events.MouseEvent;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class CheckBox extends BaseButton 
	{
		
		private var _checked:Boolean = false
		
		public var checkedAct:Function;
		public var unCheckedAct:Function;
		
		public function CheckBox() 
		{
			
		}
		
		override protected function MClick(e:MouseEvent):void 
		{
			super.MClick(e);
			checked = !checked;
		}
		
		public function get checked():Boolean 
		{
			return _checked;
		}
		
		public function set checked(value:Boolean):void 
		{
			_checked = value;
			if (value)
			{
				gotoAndStop(2);
				if (checkedAct != null)
				{
					checkedAct();
				}
			}
			else
			{
				gotoAndStop(1);
				if (unCheckedAct != null)
				{
					unCheckedAct();
				}
			}
		}
	}

}