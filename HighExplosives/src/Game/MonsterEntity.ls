package HighExplosives.Game
{
	public class MonsterEntity extends DynamicEntity{
	
		public var count:Number;
		
		public var moveCollide:boolean = true;
		
		public function MonsterEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer)	
		{
		
			super(level, x, y, renderer, .25, .25, 100, 0, 0);
	
		}
		
		public function onCollision(objectCollidedWith:DynamicEntity) 
		{
			

			if(!(objectCollidedWith.isMonster())){
				level.spawnMonsterDeath(level.dynamicEntityList[0].getX(), level.dynamicEntityList[0].getY(), this, .5, 10,5);
				this.destroy();
				
			}
			else
			{
				this.setX(this.getX()+5);
				this.setY(this.getY()-5);
								
			}
			
		}
		
		
		
		public function isMonster():boolean
		{
			return true;
		}
	}	
}