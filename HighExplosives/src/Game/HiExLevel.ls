package HighExplosives.Game
{

    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;

	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.LoomGameObject;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	public class HiExLevel {
	
		public var layer:CCScaledLayer;
		public var group:LoomGroup;
		
		public var entityList:Vector.<Entity> = new Vector.<Entity>();
		
		public function HiExLevel(layer:CCScaledLayer) {
            // Setup anything else, like UI, or game objects.
            var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 0.5;
            layer.addChild(bg);
            
            spawnTestEntity("assets/logo.png", 240, 240);
            
            layer.onTouchBegan = function(id:int, x:int, y:int) 
            {
            	entityList[0].move(x, y);
            }
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
	}

}