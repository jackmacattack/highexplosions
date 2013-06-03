package HighExplosives.Game
{

    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.CCTMXTiledMap;

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
		
		public function HiExLevel(layer_:CCScaledLayer, timeManager_:TimeManager) 
		{
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
            
            spawnTestEntity(240, 240);
			
			
			timeManager.addTickedObject(this);
		}
		
		public function spawnTestEntity(x:Number, y:Number)
		{
		
			var renderer = new Renderer("assets/logo.png", x, y, .5, 0);
			layer.addChild(renderer.sprite);
			
			var e = new TestEntity(this, x, y, renderer); 
			dynamicEntityList.push(e);
			
  			var gestureManager:GestureManager = new GestureManager(layer);
			var control = new PlayerController(this, e, gestureManager);
			controllerList.push(control);
		
			if(following == null) {
				following = e;
				moveCamera();
			}

		}
		
		public function spawnTestExplosive(x:Number, y:Number, speed:Number, angle:Number, time:Number, duration:Number, damage:Number, area:Number)
		{
		
			var renderer = new Renderer("assets/bomb1.png", x, y, 1, 0);
			layer.addChild(renderer.sprite);
			
			var e:Explosive = new Explosive(this, x, y, renderer, speed, angle, time, duration, damage, area);
			dynamicEntityList.push(e);
		
		}
		
		public function spawnExplosion(x:Number, y:Number, duration:Number, damage:Number, area:Number)
		{
		
			var renderer = new Renderer("assets/bombex2.png", x, y, 3, 0);
			layer.addChild(renderer.sprite);
			
			var e:Explosion = new Explosion(this, x, y, renderer, duration, damage, area);
			dynamicEntityList.push(e);
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
			
			layer.x = -1 * (following.getX()-Cocos2D.getDisplayWidth() / 2);
			layer.y = -1 * (following.getY()-Cocos2D.getDisplayHeight() / 2);
		
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
