package HighExplosives.Game
{

    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.CCTMXTiledMap;
    import CocosDenshion.SimpleAudioEngine;

	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.TickedComponent;
	import Loom.GameFramework.ITicked;
	import Loom.GameFramework.TimeManager;
	import Loom.GameFramework.LoomGameObject;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	import com.rmc.data.types.GestureManagerOptions;
    import com.rmc.managers.GestureManager;
    import com.rmc.data.types.GestureDelegateData;
    import com.rmc.applications.AbstractLoomDemo;
    
	public class HiExLevel extends LoomGroup implements ITicked {
	
		public var timeManager:TimeManager;
		
  		
		public var layer:CCScaledLayer;
		public var following:Entity;
		
		public var map:CCTMXTiledMap;
		
		
		public var controllerList:Vector.<Controller> = new Vector.<Controller>();
		public var dynamicEntityList:Vector.<DynamicEntity> = new Vector.<DynamicEntity>();
		public var worldList:Vector.<Entity> = new Vector.<Entity>();
		
		public function HiExLevel(layer_:CCScaledLayer, timeManager_:TimeManager) {
			layer = layer_;
			timeManager = timeManager_;
		}
		
      	public function initialize(_name:String = null):void
      	{
         	super.initialize(_name);
         	
		
            // Setup anything else, like UI, or game objects.
            
            trace("Loading test_map_1.tmx...");
            map = CCTMXTiledMap.tiledMapWithTMXFile("assets/tilemaps/test_map_1.tmx");
            layer.addChild(map);
            
            spawnTestEntity("assets/logo.png", 240, 240);
            /*SimpleAudioEngine.sharedEngine().preloadBackgroundMusic("assets/Tribal.mp3");
            SimpleAudioEngine.sharedEngine().setBackgroundMusicVolume(0.0);
			SimpleAudioEngine.sharedEngine().playBackgroundMusic("assets/Tribal.mp3", true);
			trace(SimpleAudioEngine.sharedEngine().getBackgroundMusicVolume());
			SimpleAudioEngine.sharedEngine().setBackgroundMusicVolume(0.0);
			trace(SimpleAudioEngine.sharedEngine().getBackgroundMusicVolume());*/
			
			timeManager.addTickedObject(this);
		}
		
		public function spawnTestEntity(name:String, x:Number, y:Number)
		{
		
			var e = new TestEntity(this, x, y); 
			dynamicEntityList.push(e);
			
  			var gestureManager:GestureManager = new GestureManager(layer);
			var control = new PlayerController(this, e, gestureManager);
			controllerList.push(control);
		
			var renderer = new TestRenderer(name, x, y);
			renderer.addBinding("x", "@mover.x");
			renderer.addBinding("y", "@mover.y");
			renderer.addBinding("scale", "@mover.scale");
			e.renderer = renderer;
			layer.addChild(renderer.sprite);

			if(following == null) {
				following = e;
				moveCamera();
			}

		}
		
		public function spawnTestExplosive(name:String, x:Number, y:Number, speed:Number, angle:Number, time:Number, duration:Number, damage:Number, area:Number)
		{
		
			var e:Explosive = new Explosive(this, x, y, 1, speed, angle, time, duration, damage, area);
			dynamicEntityList.push(e);
		
			var renderer = new TestRenderer(name, x, y);
			renderer.addBinding("x", "@mover.x");
			renderer.addBinding("y", "@mover.y");
			renderer.addBinding("scale", "@mover.scale");
			e.renderer = renderer;
			layer.addChild(renderer.sprite);
		}
		
		public function spawnExplosion(x:Number, y:Number, duration:Number, damage:Number, area:Number)
		{
		
			var e:Explosion = new Explosion(this, x, y, 1, duration, damage, area);
			dynamicEntityList.push(e);
		
			var renderer = new TestRenderer("assets/bombex2.png", x, y);
			renderer.addBinding("x", "@mover.x");
			renderer.addBinding("y", "@mover.y");
			renderer.addBinding("scale", "@mover.scale");
			e.renderer = renderer;
			layer.addChild(renderer.sprite);
		}
		
		public function removeEntity(e:Entity)
		{
		
			dynamicEntityList.remove(e);
			layer.removeChild(e.renderer.sprite);

		}
		
		public function moveCamera()
		{
		
			if(following == null) {
				return;
			}
			
			layer.x = -1 * (following.getX()-240);
			layer.y = -1 * (following.getY()-240);
		
		}
		
		override public function onTick() 
		{
			var dt:Number = timeManager.TICK_RATE; 
			
			
			for(var i:int = 0; i < controllerList.length; i++) {
				controllerList[i].update();
			}
			
			for(var j:int = 0; j < dynamicEntityList.length; j++) {
				dynamicEntityList[j].move(dt);
			}
			
			moveCamera();
		}

	}

}
