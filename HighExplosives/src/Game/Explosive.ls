package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TickedComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class Explosive extends DynamicEntity {
	
		public var time:Number;
		
		public var duration:Number;
		public var damage:Number;
		public var area:Number;
		
		public function Explosive(level:HiExLevel, x:Number, y:Number, renderer:Renderer, speed:Number, angle:Number, time_:Number, duration_:Number, damage_:Number, area_:Number)
		{
			super(level, x, y, renderer, 0, 0, speed, speed, angle);
			time = time_;
			damage = damage_;
			duration = duration_;
			area = area_;
		}
	
		public function explode() {
			level.spawnExplosion(x, y, duration, damage, area);
			destroy();
		}
		
		override public function move(dt:Number) {
			time -= dt;
			
			if(time < 0) {
				explode();
			}
			else {
				super.move(dt);
			}
		}
	}
	
}