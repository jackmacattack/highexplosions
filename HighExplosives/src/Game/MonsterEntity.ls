package HighExplosives.Game
{

	public class MonsterEntity extends DynamicEntity {
		
		public function MonsterEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer)	
		{
		
			super(level, x, y, renderer, .25, .25, 100, 0, 0);
	
		}
		
		public function isColliding(object:DynamicEntity):boolean
		{
			if(object instanceof MonsterEntity) {
				return false;
			}
			
			return super.isColliding(object);
		}
		
		public function onCollision(object:DynamicEntity) 
		{
			//if(!(objectCollidedWith.isMonster())){
				this.destroy();
			//}
			
		}
		
		public function isMonster():boolean
		{
			return true;
		}	
	
	}
}