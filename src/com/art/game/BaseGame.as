package com.art.game 
{
	import com.art.display.ASprite;
	import flash.utils.getTimer;
	
	import flash.events.Event;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class BaseGame extends ASprite 
	{
		private var oldTime:Number = 0;
		private var newTime:Number = 0;
		private var _paused:Boolean = true;
		
		public var deltaTime:Number = 0;
		public var updates:Array = [];
		public var timers:Array = [];
		
		public static var SELF:BaseGame;
		
		public function BaseGame() 
		{
			SELF = this;
			updates.push(update);
			oldTime = getTimer();
		}
		
		public function addUpdate(upd:Function):void
		{
			updates.push(upd);
		}
		
		public function removeUpdate(upd:Function):void
		{
			var indx:int = updates.indexOf(upd);
			if (indx > -1)
				updates.splice(indx, 1);
		}
		
		public function addTimer(tmr:GameTimer):void
		{
			timers.push(tmr);
		}
		
		public function removeTimer(tmr:GameTimer):void
		{
			var indx:int = timers.indexOf(tmr);
			if (indx > -1)
				timers.splice(indx, 1);
		}
		
		override protected function onUpdate(e:Event):void 
		{
			super.onUpdate(e);
			newTime = getTimer();
			deltaTime = (newTime - oldTime) / 1000;
			oldTime = newTime;
			
			if (!paused)
			{
				updates.forEach(function(f)
				{
					if (f != null)
					{
						f();
					}
				});
			}
		}
		
		public function update():void
		{
			
		}
		
		public function get paused():Boolean 
		{
			return _paused;
		}
		
		public function set paused(value:Boolean):void 
		{
			_paused = value;
			
			timers.forEach(function(t)
			{
				if (paused)
					GameTimer(t).pause();
				else
					GameTimer(t).resume();
			});
		}
	}

}