package com.art.game 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Arman Kara
	$(CBI)*/
	public class PhysicEntity extends GameEntity
	{
		public var sprite:Sprite;
		public var bodyDef:b2BodyDef;
		public var polyShape:b2PolygonShape;
		public var fixtureDef:b2FixtureDef;
		public var body:b2Body;
		public var world:b2World;
		public var ptm:Number;
		
		public function PhysicEntity() 
		{
			world = PhysicsGame.SELF.world;
			ptm = PhysicsGame.SELF.ptm;
			
			polyShape = new b2PolygonShape();
			bodyDef = new b2BodyDef();
			fixtureDef = new b2FixtureDef();
		}
		
		public function getCollisions():Vector.<b2Contact>
		{
			var contacts:Vector.<b2Contact> = new Vector.<b2Contact>();
			if (!body)
				return contacts;
			for (var c:b2ContactEdge = body.GetContactList(); c; c = c.next)
			{
				contacts.push(c.contact);
			}
			return contacts;
		}
		
		public function collidesWith(body:b2Body):Boolean
		{
			var result:Boolean;
			var collisions:Vector.<b2Contact> = getCollisions();
			collisions.forEach(function(c)
			{
				var contact:b2Contact = c;
				if (contact.GetFixtureA().GetBody() == body)
					result = true;
				if(contact.GetFixtureB().GetBody() == body)
					result = true;
			});
			return result;
		}
		
		override public function dispose():void
		{
			super.dispose();
			if (body)
				world.DestroyBody(body);
			body = null;
			polyShape = null;
			bodyDef = null;
			fixtureDef = null;
			sprite = null;
			world = null;
			ptm = NaN;
		}
	}

}