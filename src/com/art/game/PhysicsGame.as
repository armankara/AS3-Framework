package com.art.game 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class PhysicsGame extends BaseGame 
	{
		public var debugDraw:Boolean = false;
		public var world:b2World;
		
		public var velocityIterations:int = 5;
		public var positionIterations:int = 1;
		public var timeStep:Number = 1.0 / 60.0;
		public var ptm:Number = 32;
		
		public static var SELF:PhysicsGame;
		
		public function PhysicsGame(fps:Number = 60, ptm:Number = 32, gravity:b2Vec2 = null)
		{
			SELF  = this;
			
			if (gravity == null)
				gravity = new b2Vec2(0, 10.0);
				
			timeStep = 1.0 / fps;
			this.ptm = ptm;
			
			world = new b2World(gravity, false);
			debug_draw();
		}
		
		private function debug_draw():void
		{
			var debug_draw:b2DebugDraw = new b2DebugDraw();
			var debug_sprite:Sprite = new Sprite();
			addChild(debug_sprite);
			debug_draw.SetSprite(debug_sprite);
			debug_draw.SetFillAlpha(0.3);
			debug_draw.SetDrawScale(ptm);
			debug_draw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			debug_draw.SetLineThickness(1.0);
			world.SetDebugDraw(debug_draw);
		}
		
		override public function update():void 
		{
			super.update();
			
			world.Step(timeStep, velocityIterations, positionIterations);
			world.ClearForces();
			
			if(debugDraw)
				world.DrawDebugData();
			
			for (var Body:b2Body = world.GetBodyList(); Body; Body = Body.GetNext())
			{
				if (Body.GetUserData() is Sprite)
				{
					var sprite:Sprite = Body.GetUserData() as Sprite;
					sprite.x = Body.GetPosition().x * ptm;
					sprite.y = Body.GetPosition().y * ptm;
					sprite.rotation = Body.GetAngle() * (180/Math.PI);
				}
			}
		}
	}

}