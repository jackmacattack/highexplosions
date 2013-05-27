package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class DynamicEntity extends Entity {
   		
   		public static final var toleranceSquared = 9;
   		
   		public var moving:boolean = false;
   		
		//The acceleration index of the entity
		public var accel:Number = 1;
		
		//The agility of the entity 
		public var agility:Number = .5;
		
		//The maximum speed of the entity
		public var maxSpeed:Number = 200;
		
		//The current velocity of the entity
		public var speed:Number = 0;
		public var xDir:Number = 0;
		public var yDir:Number = 0;
		
		//The position of the current target
		public var targetX:Number = 0;
		public var targetY:Number = 0;
		
		public function DynamicEntity(x_:Number, y_:Number)	
		{
			super(x_, y_);
		}
		
		public function setTarget(newX:Number, newY:Number)
		{
			targetX = newX;
			targetY = newY;
			
			var mag:Number = Math.pow((targetX - x) * (targetX - x) + (targetY - y) * (targetY - y), .5);
			xDir = (targetX - x)/mag;
			yDir = (targetY - y)/mag;
			
			speed = speed * agility;
			moving = true;
		}
		
		public function inRangeOfTarget():boolean 
		{
			return (x-targetX)*(x-targetX)+(y-targetY)*(y-targetY) <= DynamicEntity.toleranceSquared;
		}
		
		public function move(dt:Number)
		{
			if(!moving) {
				return;
			}
			
			speed = speed * (1 - accel) + maxSpeed * accel;
			var dx:Number = speed * xDir;
			var dy:Number = speed * yDir;
			
			x += dx * dt;
			y += dy * dt;
			
			renderer.x = x;
			renderer.y = y;
			
			if(inRangeOfTarget()) {
				moving = false;
			}
			 
			//Tween.to(renderer.sprite, 1, {"x": newX, "y": newY, "ease":EaseType.EASE_OUT});
		}
			
	}

	public class TestEntity extends DynamicEntity {
	
		public function TestEntity(x_:Number, y_:Number)	
		{
			super(x_, y_);
		}
	}
	
}