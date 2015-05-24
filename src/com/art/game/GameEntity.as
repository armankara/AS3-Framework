package com.art.game 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class GameEntity 
	{
		public function GameEntity() 
		{
			BaseGame.SELF.addUpdate(update);
		}
		
		public function dispose():void
		{
			BaseGame.SELF.removeUpdate(update);
		}
		
		public function update():void
		{
			
		}		
	}

}