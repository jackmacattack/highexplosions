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
		
		public var angle:Number = 0;
		
		//public var xDir:Number = 0;
		//public var yDir:Number = 0;
		
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
			
			var offset:Number = x > targetX ? Math.PI /2 : 0;
			
			var aTan = Math.atan(Math.abs((targetY - y)/(targetX - x)));
			
			var xCheck = x < targetX;
			var yCheck = y < targetY;
			
			if(xCheck && yCheck) {
				angle = aTan;
			}
			else if(xCheck) {
				angle = 2 * Math.PI - aTan;
			}
			else if(yCheck) {
				angle = Math.PI - aTan;
			}
			else {
				angle = Math.PI + aTan;
			}
			
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
			var dx:Number = speed * Math.cos(angle);
			var dy:Number = speed * Math.sin(angle);
			
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