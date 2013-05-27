package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class Entity extends LoomComponent {
	
		//The level this entity inhabits
   		//private HiExLevel level;
   		public var renderer:TestRenderer;
   		
		//The current position of the entity
		public var x:Number;
		public var y:Number;
		
		//The scale of the entity sprite. Should most likely remain 1
		private var scale:Number = 1;
		
		//The object's hitbox for collision detection
		//private var hitbox:Rectangle;
		
		public function Entity(x_:Number, y_:Number)	
		{
			setPosition(x_, y_);
		}
		
		public function getX():Number 
		{
			return x;
		}
		
		public function getY():Number 
		{
			return y;
		}
		
		public function setPosition(x_:Number, y_:Number) 
		{
			x = x_;
			y = y_;
		}
		
		public function move(newX:Number, newY:Number)
		{
			Tween.to(renderer.sprite, .5, {"x": newX, "y": newY, "ease":EaseType.EASE_OUT});
		}
		
		public function onCollide(otherEntity:Entity) 
		{
			Tween.killTweensOf(this);
		}
	}

	public class TestEntity extends Entity {
	
		public function TestEntity(x_:Number, y_:Number)	
		{
			super(x_, y_);
		}
	}
}