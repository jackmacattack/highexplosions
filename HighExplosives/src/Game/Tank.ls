package HighExplosives.Game 
{
	import CocosDenshion.SimpleAudioEngine;

	public class Tank extends DynamicEntity
	{
	
		private var turretRenderer:Renderer;
	
		private var maxHitPoints:Number;
		private var hitPoints:Number;
		private var coolDown:Number;
		
		private var minRange:Number;
		private var range:Number;
		private var time:Number;
		private var duration:Number;
		private var damage:Number;
		private var area:Number;
	
		public function Tank(level:HiExLevel, x:Number, y:Number, renderer:Renderer, accel:Number, maxSpeed:Number, turretRenderer_:Renderer, 
		hitPoints_:Number, minRange_:Number, range_:Number, time_:Number, duration_:Number, damage_:Number, area_:Number)	
		{
			super(level, x, y, renderer, accel, maxSpeed, 0, 0);
			
			turretRenderer = turretRenderer_;
			maxHitPoints = hitPoints_;
			hitPoints = hitPoints_;
			minRange = minRange_;
			range = range_;
			time = time_;
			duration = duration_;
			damage = damage_;
			area = area_;
		}
		
		override function setX(value:Number) {
		
			super.setX(value);
			turretRenderer.x = value;
		
		}
		
		override function setY(value:Number) {
		
			super.setY(value);
			turretRenderer.y = value;
		
		}
		
		public function throwBomb(speed:Number, angle:Number) 
		{
			turretRenderer.rotation = angle;
			level.spawnTestExplosive(x, y, this, Math.clamp(Math.pow(speed, 2), minRange, range), angle, time, duration, damage, area);
		}
		
		public function applyDamage(value:Number) {
		
			Console.print(hitPoints);

			if(coolDown > 0) {
				return;
			}
			
			hitPoints -= value;
			coolDown = 1;
			if(hitPoints <= 0) {
			
				this.level.endGame();
			}
			
		}
		
		override public function isColliding(object:DynamicEntity):boolean 
		{
			if(object instanceof Explosive) {
				return this != (object as Explosive).ownerOf
			}
			
			return boundingBoxCheck(object);
		}
		
		
		override public function onCollision(object:DynamicEntity) 
		{
			if(object instanceof MonsterEntity) {
				(object as MonsterEntity).explode();
			}
		}
		
		override function move(dt:Number)
		{
			if(moving==false)
			{
				SimpleAudioEngine.sharedEngine().playEffect("assets/tank.mp3", true);
			}
		
			if(coolDown > 0)
				coolDown -= dt;
		
			super.move(dt);

		}
	}

}
