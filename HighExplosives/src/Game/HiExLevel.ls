package HighExplosives.Game
{

    import cocos2d.Cocos2D;
    import cocos2d.CCPoint;
    import cocos2d.CCSize;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.CCTMXLayer;
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
		public var collide:CCTMXLayer;
		
		public var controllerList:Vector.<Controller> = new Vector.<Controller>();
		public var dynamicEntityList:Vector.<DynamicEntity> = new Vector.<DynamicEntity>();
		public var worldList:Vector.<Entity> = new Vector.<Entity>();
		
		public var totalTime:Number=0;
		
		public var timeTillNextSpawn=3;
		
		
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
            collide = map.layerNamed("angles");
            layer.addChild(map);
            
            
            SimpleAudioEngine.sharedEngine().preloadBackgroundMusic("assets/Tribal.mp3");
            SimpleAudioEngine.sharedEngine().setBackgroundMusicVolume(0.0);
			SimpleAudioEngine.sharedEngine().playBackgroundMusic("assets/Tribal.mp3", true);
			trace(SimpleAudioEngine.sharedEngine().getBackgroundMusicVolume());
			SimpleAudioEngine.sharedEngine().setBackgroundMusicVolume(0.0);
			trace(SimpleAudioEngine.sharedEngine().getBackgroundMusicVolume());

            spawnTestEntity(240, 240);
            spawnMonsterEntity(300,300);
			
			timeManager.addTickedObject(this);
		}
		
		public function isCollidingWithWorld(e:Entity):boolean 
		{
		
		   /*
			//Console.print(collide.getChildrenCount());
			//for(var i:int = 0; i < collide.getChildrenCount(); i++) {
			
				var tile:CCSize = map.getTileSize();
			
				var p:CCPoint = new CCPoint(Math.floor(e.getX() / tile.width), Math.floor(e.getY() / tile.height));
				//var p:CCPoint = new CCPoint(0, 1);
				
				var tileNum:Number = collide.tileGIDAt(p);
				
				return tileNum != 0;
			
			*/
			/*
				if(tileNum != 0) {
					Console.print(tileNum);
				}
				
				
				var s:CCSprite = collide.getChildren().objectAtIndex(i) as CCSprite;
				if(s.boundingBox().containsPoint(p)) {
					return true;
				}
			*/
			//}
			return false; 
		
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
		
		public function dynamicCollides():boolean{
		
			for ( var i = 1; i <dynamicEntityList.length ; i++)
			{
				if (dynamicEntityList[i-1].isCollidingWithDynamic(dynamicEntityList[i]))
					return true;
			}
			 
				return false; 
		}
		
		public function spawnMonsterEntity(x:Number, y:Number){
			var renderer = new Renderer("assets/monster.png", x, y, .5, 0);
			layer.addChild(renderer.sprite);
			
			var e = new MonsterEntity(this, x, y, renderer); 
			dynamicEntityList.push(e);
			
			var control = new MonstersController(this, e, dynamicEntityList[0]);
			controllerList.push(control);
			
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
			
			totalTime+=dt;
			
			
			timeTillNextSpawn-=dt;
			if (timeTillNextSpawn<0){
				trace("new monster");
				spawnMonsterEntity(600,300);
				timeTillNextSpawn=5;
			}
			
			if (timeTillNextSpawn<0)
			{
				trace("new monster");
				spawnMonsterEntity(550,550);
				timeTillNextSpawn=2.5;
			}
			
			
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
