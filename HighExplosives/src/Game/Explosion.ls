package HighExplosives.Game
{
	import cocos2d.CCRect;
	
	public class Explosion extends Entity {
	
		public var ownerOf:Entity;
	
		public var duration:Number;
		public var damage:Number;
		public var area:Number;
		
		public function Explosion(level:HiExLevel, x:Number, y:Number, renderer:Renderer, owner_:Entity, duration_:Number, damage_:Number, area_:Number)
		{
			super(level, x, y, renderer);
			ownerOf = owner_;
			duration = duration_;
			damage = damage_;
			area = area_;
		}
		
		override public function update(dt:Number) 
		{
		
			duration -= dt;
			
			if(duration <= 0) {
				destroy();
			}
		}
		override public function isColliding(object:Entity):boolean 
		{
			
			if(object instanceof Tank) {
				if((object as Tank) == ownerOf) {
					return false;
				}
			}
			
			return boundingBoxCheck(object); 
			
		}
		
		override public function onCollision(object:DynamicEntity)
		{
		
			if(object instanceof Tank) {
				(object as Tank).applyDamage(damage);
			}
			else if(object instanceof MonsterEntity) {
				(object as MonsterEntity).explode();
				//((ownerOf.controller) as PlayerController).increaseScore(10);
			}
			
		}
		
	}
	
}
