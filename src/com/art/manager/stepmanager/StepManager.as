package com.art.manager.stepmanager 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Arman Kara
	 */
	public class StepManager extends MovieClip 
	{
		public var data:*;
		public var steps:Vector.<StepPage> = new Vector.<StepPage>();
		private var prevPage:int = -1;
		private var currentPage:int = 0;
		
		protected function onFinish():void { }
		
		public function addStep(step:StepPage):int
		{
			var index:int = steps.push(step) - 1;
			step.manager = this;
			
			if (steps.length == 1)
				updateView();
			
			return index;
		}
		
		public function restart():void
		{
			prevPage = -1;
			currentPage = 0;
			updateView();
		}
		
		public function nextStep():void
		{
			setStep(currentPage + 1);
		}
		
		public function prevStep():void
		{
			setStep(currentPage - 1);
		}
		
		public function setStep(step:int):void
		{
			var changed:Boolean = true;
			var finished:Boolean;
			var _prevPage:int = currentPage;
			
			currentPage = step;
			
			if (currentPage < 0)
			{
				changed = false;
				currentPage = 0;
			}
			
			if (currentPage == steps.length)
			{
				changed = false;
				currentPage = steps.length - 1;
				finished = true;
			}
			
			if (currentPage != _prevPage)
				prevPage = _prevPage;
			
			if (changed)
				updateView();
			
			if (finished)
				onFinish();
		}
		
		private function updateView():void
		{
			if (CurrentPage)
			{
				if (PreviousPage)
				{
					removeChild(PreviousPage);
					PreviousPage.onRemove();
				}
				
				addChild(CurrentPage);
				CurrentPage.onAdded();
			}
		}
		
		public function destroy():void
		{
			if (CurrentPage)
			{				
				removeChild(CurrentPage);
				CurrentPage.onRemove();
			}
			
			while (steps.length > 0)
				steps.pop();
			steps = null;
		}
		
		public function get CurrentPage():StepPage
		{
			var result:StepPage = null;
			if (currentPage < steps.length)
				result = steps[currentPage];
			return result;
		}
		
		public function get PreviousPage():StepPage
		{
			var result:StepPage = null;
			if (prevPage > -1)
				result = steps[prevPage];
			return result;
		}
	}
}