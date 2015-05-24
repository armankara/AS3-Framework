package com.art.display 
{
	import flash.display.Sprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class AMask extends Sprite 
	{	
		public function AMask(w_:Number, h_:Number) 
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, w_, h_);
			graphics.endFill();
		}		
	}
}