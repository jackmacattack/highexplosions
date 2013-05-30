package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TickedComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class Explosion extends DynamicEntity {
	
		public var duration:Number;
		public var damage:Number;
		public var area:Number;
		
		public function Explosion(level:HiExLevel, x:Number, y:Number, renderer:Renderer, duration_:Number, damage_:Number, area_:Number)
		{
			super(level, x, y, renderer, 0, 0, 0, 0, 0);
			duration = duration_;
			damage = damage_;
			area = area_;
		}
		
		override public function move(dt:Number) {
		
			duration -= dt;
			
			if(duration <= 0) {
				destroy();
			}
		}
		
	}
	
}
