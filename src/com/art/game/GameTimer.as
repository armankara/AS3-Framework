package com.art.game 
{
	import com.art.timer.AdvancedTimer;
	import flash.events.TimerEvent;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class GameTimer 
	{
		private var timer:AdvancedTimer;
		private var update:Function;
		private var complete:Function;
		
		public function GameTimer(delay:Number, complete:Function = null, update:Function = null, repeat:int = 0)
		{
			this.update = update;
			this.complete = complete;
			timer = new AdvancedTimer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, onTime);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			BaseGame.SELF.addTimer(this);
		}
		
		protected function onTime(e:TimerEvent):void 
		{
			if (update != null)
				update();
		}
		
		protected function onComplete(e:TimerEvent):void 
		{
			if (complete != null)
				complete();
		}
		
		public function start():void
		{
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();
		}
		
		public function resume():void
		{
			timer.resume();
		}
		
		public function pause():void
		{
			timer.pause();
		}
		
		public function reset():void
		{
			timer.reset();
		}
		
		public function dispose():void
		{
			BaseGame.SELF.removeTimer(this);
			this.update = null;
			this.complete = null;
			timer.removeEventListener(TimerEvent.TIMER, onTime);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			timer.reset();
			timer = null;
		}
	}

}