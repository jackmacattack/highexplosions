package HighExplosives.Game
{
	import cocos2d.CCPoint;
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
		
		public var controller:Controller; 
		
		//The object's hitbox for collision detection
		private var hitW:Number;
		private var hitH:Number;
		
		public function Entity(level_:HiExLevel, x_:Number, y_:Number, renderer_:Renderer, hitScale:Number)	
		{
			level = level_;
			setPosition(x_, y_);
			renderer = renderer_;
			
			hitW = renderer.sprite.getContentSize().width * hitScale;
			hitH = renderer.sprite.getContentSize().height * hitScale;
		}
		
		public function getX():Number 
		{
			return x;
		}
		
		public function getY():Number 
		{
			return y;
		}
		
		public function getWidth():Number 
		{
			return hitW;
		}
		
		public function getHeight():Number 
		{
			return hitH;
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
		
			var objectBox:CCRect=new CCRect();
			var objectBox2:CCRect=new CCRect();
			objectBox.setRect(x, y, hitW, hitH);
			objectBox2.setRect(object.getX(), object.getY(), object.getWidth(), object.getHeight());
			
			return objectBox2.intersectsRect(objectBox);
			//return false;
			
		}
		
		public function isColliding(object:Entity):boolean
		{
		
			return false;
		
		}
		
		public function onCollision(object:DynamicEntity)
		{
			//Console.print("Bang");
		}
	}
	
}
