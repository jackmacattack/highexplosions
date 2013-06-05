package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TickedComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	import CocosDenshion.SimpleAudioEngine;
	
	public class Explosive extends DynamicEntity {
	
		public var ownerOf:Entity;
	
		public var time:Number;
		
		public var duration:Number;
		public var damage:Number;
		public var area:Number;
		
		public function Explosive(level:HiExLevel, x:Number, y:Number, renderer:Renderer, owner_:Entity, speed:Number, angle:Number, time_:Number, duration_:Number, damage_:Number, area_:Number)
		{
			super(level, x, y, renderer, 0, speed, speed, angle);
			ownerOf = owner_; 
			time = time_;
			damage = damage_;
			duration = duration_;
			area = area_;
		}
	
		public function explode() {
			level.spawnExplosion(x, y, ownerOf, duration, damage, area);
			SimpleAudioEngine.sharedEngine().playEffect("assets/Depth Charge Short.mp3");
			destroy();
		}
		
		override public function update(dt:Number) {
			time -= dt;
			
			if(time <= 0) {
				explode();
			}
			else {
				super.update(dt);
			}
		}
		
		override public function isColliding(object:DynamicEntity):boolean
		{
			if(object instanceof Tank) {
				return (object as Tank) != ownerOf;
			}
		
			if(object instanceof Explosive) {
				return false;
			}
		
			return boundingBoxCheck(object);
		}
		
	}
	
}
