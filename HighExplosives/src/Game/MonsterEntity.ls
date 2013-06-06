package HighExplosives.Game
{
	public class MonsterEntity extends DynamicEntity {
	
		public var count:Number;
		public var damage:Number;
		
		public function MonsterEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer, hitScale:Number)	
		{
			super(level, x, y, renderer, hitScale, .25, 100, 0, 0);
			damage = 10;
		}
		
		public function explode() {
			level.spawnMonsterDeath(x, y, this, .5, damage, 2);
			this.destroy();
		}
		
		public function isColliding(object:Entity):boolean
		{
			return boundingBoxCheck(object);
		}
		
	}	
}
