package HighExplosives.Game
{
	public class MonsterEntity extends DynamicEntity{
	
		public var count:Number;
		public var damage:Number;
		
		public function MonsterEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer)	
		{
			super(level, x, y, renderer, .25, 100, 0, 0);
			damage = 10;
		}
		
		public function explode() {
			level.spawnMonsterDeath(x, y, this, .5, damage, 2);
			this.destroy();
		}
		
		public function isColliding(object:DynamicEntity):boolean
		{
			return boundingBoxCheck(object);
		}
		
	}	
}
