package HighExplosives.Game
{
	import cocos2d.CCRect;

	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TickedComponent;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class Entity extends TickedComponent {
		
		//The level this entity inhabits
   		protected var level:HiExLevel;
   		public var renderer:Renderer;
   		
		//The current position of the entity
		protected var x:Number;
		protected var y:Number;
		
		//The object's hitbox for collision detection
		//private var hitbox:Rectangle;
		
		public function Entity(level_:HiExLevel, x_:Number, y_:Number, renderer_:Renderer)	
		{
			level = level_;
			setPosition(x_, y_);
			renderer = renderer_;
		}
		
		public function getX():Number 
		{
			return x;
		}
		
		public function getY():Number 
		{
			return y;
		}
		
		public function setX(x_:Number) 
		{
			x = x_;
			renderer.x = x_;
		}
		public function setY(y_:Number) 
		{
			y = y_;
			renderer.y = y_;
		}
		public function setPosition(x_:Number, y_:Number) 
		{
			x = x_;
			y = y_;
		}
		
		public function destroy() 
		{
			level.addToKill(this);
		}
		
		public function update(dt:Number)
		{}
		
		public function boundingBoxCheck(object:Entity):boolean 
		{
		
			var objectBox:CCRect=object.renderer.sprite.boundingBox();
			var objectBox2:CCRect=this.renderer.sprite.boundingBox();
			
			return objectBox.intersectsRect(objectBox2);
		}
		
		public function isColliding(object:DynamicEntity):boolean
		{
		
			return false;
		
		}
		
		public function onCollision(object:DynamicEntity)
		{
			//Console.print("Bang");
		}
	}
	
}