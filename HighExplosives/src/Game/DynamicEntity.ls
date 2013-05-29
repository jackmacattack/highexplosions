package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class DynamicEntity extends Entity {
   		
   		public static final var TOLERANCE:Number = 4;
   		public static final var ANGULAR_TOLERANCE:Number = Math.PI / 24;
   		public static final var MIN_SPEED:Number = 4;
   		
   		public var moving:boolean = false;
   		public var decel:boolean = false;
   		public var turning:boolean = false;
   		
		//The acceleration index of the entity
		public var accel:Number;
		
		//The agility of the entity 
		public var agility:Number;
		
		//The maximum speed of the entity
		public var maxSpeed:Number;
		
		//The current velocity of the entity
		public var speed:Number;
		
		public var angle:Number;
		
		//The position of the current target
		public var targetX:Number;
		public var targetY:Number;
		
		public function DynamicEntity(x_:Number, y_:Number, accel_:Number, agility_:Number, maxSpeed_:Number, speed_:Number, angle_:Number)	
		{
			super(x_, y_);
			accel = accel_;
			agility = agility_;
			maxSpeed = maxSpeed_;
			speed = speed_;
			angle = angle_;
		}
		
		private function calculateAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
		
			var aTan = Math.atan(Math.abs((y2 - y1)/(x2 - x1)));
			
			var xCheck = x1 < x2;
			var yCheck = y1 < y2;
			
			if(xCheck && yCheck) {
				return aTan;
			}
			else if(xCheck) {
				return 2 * Math.PI - aTan;
			}
			else if(yCheck) {
				return Math.PI - aTan;
			}
			else {
				return Math.PI + aTan;
			}
			
		}
		
		public function setTarget(newX:Number, newY:Number)
		{
			targetX = newX; 
			targetY = newY;
			
			var offset:Number = x > targetX ? Math.PI /2 : 0;
			
			//angle = calculateAngle(x, y, targetX, targetY);
			//speed = speed * agility;
			
			decel = true;
			turning = true;
		}
		private function distanceToTarget():Number
		{
			return (x-targetX)*(x-targetX)+(y-targetY)*(y-targetY);
		}
		
		public function inRangeOfTarget():boolean 
		{
			return distanceToTarget() <= DynamicEntity.TOLERANCE;
		}
		
		public function move(dt:Number)
		{
			
			if(turning) {
				var targetAngle:Number = calculateAngle(x, y, targetX, targetY);
				if(Math.abs(targetAngle - angle) > Math.PI) {
					targetAngle -= 2 * Math.PI;
				}
				var snap:boolean = false;
				
				if(!moving) {
					Console.print("Snap");
					snap = true;
				}
				else {
					angle = angle * (1 - agility) + targetAngle * agility;
					
					
					if(angle < 0) {
						angle += 2 * Math.PI;
					}
					
					Console.print(Math.abs(angle - targetAngle));
					
					if(Math.abs(angle - targetAngle) < DynamicEntity.ANGULAR_TOLERANCE) {
						snap = true;
					}
				}
				
				if(snap) {
					angle = targetAngle;
					turning = false;
					decel = false;
					moving = true;
				}
			}
			
			if(!moving) {
				return;
			}
			
			if(!decel) {
				var check:Number = (speed / (accel + agility - accel * agility) ) * dt;
				decel = distanceToTarget() < check * check;
				//Console.print(distanceToTarget() + " ? " + check * check + " " + decel);
			}
			
			if(decel) {
				speed = speed * (1 - accel) * (1 - agility);
			}
			else {
				speed = speed * (1 - accel) + maxSpeed * accel;
			}
			
			var dx:Number = speed * Math.cos(angle);
			var dy:Number = speed * Math.sin(angle);
			
			x += dx * dt;
			y += dy * dt;
			
			renderer.x = x;
			renderer.y = y;
			
			if(inRangeOfTarget() || speed < DynamicEntity.MIN_SPEED) {
				moving = false;
				decel = false;
			}
			
		}
			
	}

	public class TestEntity extends DynamicEntity {
	
		public function TestEntity(x_:Number, y_:Number)	
		{
			super(x_, y_, .1, .1, 200, 0, 0);
		}
		
	}
	
}