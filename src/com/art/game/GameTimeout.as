package com.art.game 
{
	import flash.events.TimerEvent;
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class GameTimeout extends GameTimer 
	{
		public function GameTimeout(complete:Function, delay:Number)
		{
			super(delay, complete, null, 1);
			start();
		}
		
		override protected function onComplete(e:TimerEvent):void 
		{
			super.onComplete(e);
			dispose();
		}
	}

}