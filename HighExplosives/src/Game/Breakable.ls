package HighExplosives.Game
{
	import cocos2d.CCRect;
	
	public class Breakable extends Entity {
		
		public function Breakable(level:HiExLevel, x:Number, y:Number, renderer:Renderer)
		{
			super(level, x, y, renderer);
		}
		
		override public function isColliding(object:Entity):boolean 
		{
			
			return boundingBoxCheck(object); 
			
		}
		
	}
	
}
