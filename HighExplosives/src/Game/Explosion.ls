package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TickedComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class Explosion extends Entity {
	
		public var duration:Number;
		public var damage:Number;
		public var area:Number;
		
		public function Explosion(level:HiExLevel, x:Number, y:Number, renderer:Renderer, duration_:Number, damage_:Number, area_:Number)
		{
			super(level, x, y, renderer);
			duration = duration_;
			damage = damage_;
			area = area_;
		}
		
		override public function update(dt:Number) {
		
			duration -= dt;
			
			if(duration <= 0) {
				destroy();
			}
		}
		
	}
	
}
