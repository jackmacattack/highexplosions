package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	import cocos2d.CCSprite;
    import cocos2d.*;
    import cocos2d.CCNode;
	
	public class DynamicEntity extends Entity {
   		
   		public static final var TOLERANCE:Number = 4;
   		public static final var ANGULAR_TOLERANCE:Number = Math.PI / 24;
   		public static final var MIN_SPEED:Number = 4;
   		
   		public var moving:boolean = false;
   		public var decel:boolean = false;
   		public var turning:boolean = false;
   		
		//The acceleration index of the entity
		public var accel:Number;
		
		//The maximum speed of the entity
		public var maxSpeed:Number;
		
		//The current velocity of the entity
		public var speed:Number;
		
		public var angle:Number;
		
		//The position of the current target
		public var targetX:Number;
		public var targetY:Number;
		
		public var collideWithWorld:boolean = false;
		
		public function DynamicEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer, accel_:Number, maxSpeed_:Number, speed_:Number = 0, angle_:Number = 0)	
		{
			super(level, x, y, renderer);
			accel = accel_;
			maxSpeed = maxSpeed_;
			speed = speed_;
			moving = speed != 0;
			angle = angle_;
		}
		
		public function setTarget(newX:Number, newY:Number)
		{
			targetX = newX; 
			targetY = newY;
			
			decel = true;
			turning = true;
		}
		
		public function distanceToTarget():Number
		{
			return (x-targetX)*(x-targetX)+(y-targetY)*(y-targetY);
		}
		
		public function inRangeOfTarget():boolean 
		{
			return distanceToTarget() <= DynamicEntity.TOLERANCE;
		}
		
		override public function update(dt:Number) {
			move(dt);
		}
		
		public function move(dt:Number)
		{
		
			var collide:boolean = false;
			
			var objectCollidesWith : DynamicEntity=level.dynamicCollides(this);
			if(objectCollidesWith != null) {
				collide = true;
				onCollision(objectCollidesWith);
			}
			
			var vec : Vector.<Entity> = level.worldCollides(this);
			
			for(var i:int = 0; i < vec.length; i++) 
			{
				vec[i].onCollision(this);
				
			}
			
			if(turning) {
			
				var targetAngle:Number = Utils.calculateAngle(targetX, targetY, x, y);
				angle = targetAngle;
				turning = false;
				decel = false;
				moving = true;
					
				renderer.rotation = angle;
			}
			
			if(!moving) {
				return;
			}
			
			//Deceleration
			
			if(!decel) {
				var check:Number = (speed / accel) * dt;
				decel = distanceToTarget() < check * check;
			}
			
			if(decel) {
				speed = speed * (1 - accel);
			}
			else {
				speed = speed * (1 - accel) + maxSpeed * accel;
			}
			
			//Calculating the actual movement
			
			var dx:Number = speed * Math.cos(angle);
			var dy:Number = speed * Math.sin(angle);
			
			var newX:Number = x + dx * dt;
			var newY:Number = y + dy * dt;
			
			if(level.isCollidingWithWorld(newX, newY) || collide) {
			 
				targetX = x;
				targetY = y;
				
			}
			else {
			
				setX(newX);
				setY(newY);
			
			}
			
			
			if(inRangeOfTarget() || speed < DynamicEntity.MIN_SPEED) {
				speed = 0;
				moving = false;
				decel = false;
			}
			
		}
		/*
		override public function onCollision(object:DynamicEntity) 
		{
			
		}	
		*/
	}
	
}
