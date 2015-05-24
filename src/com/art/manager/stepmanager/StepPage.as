package com.art.manager.stepmanager 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class StepPage extends Sprite 
	{
		private var added:Boolean;
		private var buttons:Vector.<Sprite> = new Vector.<Sprite>();
		
		public function StepPage() { }
		
		public function onAdded():void
		{
			for each (var button:Sprite in buttons)
				createButton(button);
			
			added = true;
		}
		
		public function onRemove():void
		{
			added = false;
			
			for each (var button:Sprite in buttons)
				deleteButton(button);
		}
		
		protected function setButton(element:Sprite):void
		{
			buttons.push(element);
			
			if (added)
				createButton(element);
		}
		
		private function createButton(element:Sprite):void
		{
			//element.mouseChildren = false;
			element.buttonMode = true;
			if (!element.hasEventListener(MouseEvent.CLICK))
				element.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function deleteButton(element:Sprite):void
		{
			//element.mouseChildren = true;
			element.buttonMode = false;
			if (element.hasEventListener(MouseEvent.CLICK))
				element.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent):void { }
		
		private var _manager:StepManager;
		public function set manager(value:StepManager):void { _manager = value; }
		public function get manager():StepManager { return _manager; }
	}
}