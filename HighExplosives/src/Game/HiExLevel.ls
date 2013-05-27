package HighExplosives.Game
{

    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;

	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.TickedComponent;
	import Loom.GameFramework.ITicked;
	import Loom.GameFramework.TimeManager;
	import Loom.GameFramework.LoomGameObject;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class HiExLevel extends LoomGroup implements ITicked {
	
		//[Inject]
		//public var timeManager:TimeManager;
		
		public var layer:CCScaledLayer;
		public var group:LoomGroup;
		
		public var entityList:Vector.<DynamicEntity> = new Vector.<DynamicEntity>();
		
		public function HiExLevel(layer_:CCScaledLayer) {
			layer = layer_;
		}
		
      	public function initialize(_name:String = null):void
      	{
         	super.initialize(_name);
		
            // Setup anything else, like UI, or game objects.
            var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 0.5;
            layer.addChild(bg);
            
            spawnTestEntity("assets/logo.png", 240, 240);
			
            layer.onTouchBegan = function(id:int, x:int, y:int) 
            {
            	entityList[0].setTarget(x, y);
			}
			
			//timeManager.addTickedObject(this);
		}
		
		public function spawnTestEntity(name:String, x:Number, y:Number)//:LoomGameObject
		{
			//var lgo = new LoomGameObject();
			//lgo.owningGroup = this;

			var mover = new TestEntity(x, y);
			//mover.scale = 0.5;
			entityList.push(mover);

			//lgo.addComponent(mover, "mover");

			var renderer = new TestRenderer(name, x, y);
			renderer.addBinding("x", "@mover.x");
			renderer.addBinding("y", "@mover.y");
			renderer.addBinding("scale", "@mover.scale");
			//renderer.mover = mover;
			mover.renderer = renderer;

			//lgo.addComponent(renderer, "renderer");

			layer.addChild(renderer.sprite);

			//lgo.initialize();

			//return lgo;
		}
		
		override public function onTick() 
		{
			var dt:Number = .01; 
            entityList[0].move(dt);
		}
		
		public function move(dt:Number) 
		{
            entityList[0].move(dt);
		}
	}

}