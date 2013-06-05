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
		
		//The object's hitbox for collision detection
		private var hitW:Number;
		private var hitH:Number;
		
		public function Entity(level_:HiExLevel, x_:Number, y_:Number, renderer_:Renderer)	
		{
			level = level_;
			setPosition(x_, y_);
			renderer = renderer_;
			
			hitW = renderer.sprite.getContentSize().width / 2;
			hitH = renderer.sprite.getContentSize().height / 2;
		}
		
		public function getX():Number 
		{
			return x;
		}
		
		public function getY():Number 
		{
			return y;
		}
		
		public function getMinX():Number 
		{
			return x - hitW;
		}
		
		public function getMinY():Number 
		{
			return y - hitH;
		}
		
		public function getMaxX():Number 
		{
			return x + hitW;
		}
		
		public function getMaxY():Number 
		{
			return y + hitH;
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
		
		public function boundingBoxCheck(object:DynamicEntity):boolean 
		{
		
			var objectBox:CCRect=object.renderer.sprite.boundingBox();
			var objectBox2:CCRect=this.renderer.sprite.boundingBox();
			
			return objectBox2.intersectsRect(objectBox);
			//return false;
			/*
			
			if(object.angle > 3 * Math.PI / 2) {
				
			}
			else if() {
			
			}
			*/
			
			/*
			var right:boolean = getMaxX() > object.getMinX();
			var left:boolean = getMinX() < object.getMaxX();
			var down:boolean = getMaxY() > object.getMinY();
			var up:boolean = getMinX() < object.getMaxY();
			
			return right && left && up && down;
			*/
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