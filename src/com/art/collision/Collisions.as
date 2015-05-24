package com.art.collision 
{
	import flash.display.DisplayObject;
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class Collisions extends Object 
	{		
		private var colitems:Array = [];
		private var colli:Array = [];
		private var colMain:DisplayObject;
		
		public function Collisions(colMain:DisplayObject) 
		{
			this.colMain = colMain;
		}
		
		public function addItem(dobj:DisplayObject):void
		{
			colitems.push(dobj);
		}
		
		public function removeItem(dobj:DisplayObject):void
		{
			var i:int = 0;
			colitems.forEach(function(e)
			{
				if (e == dobj)
				{
					colitems.splice(i, 1);
				}
				i++;
			});
		}
		
		public function removeAll():void
		{
			while (colitems.length > 0)
			{
				colitems.splice(0, 1);
			}
		}
		
		public function checkCollisions():Array
		{
			colli = [];
			
			colitems.forEach(function(e)
			{
				if (colMain.hitTestObject(e))
				{
					colli.push(e);
				}
			});
			
			return colli;
		}
		
		public function get numCollides():int
		{
			return colli.length;
		}
		
		public function get numItems():int
		{
			return colitems.length;
		}
		
	}

}