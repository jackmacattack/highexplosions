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
		public var uiLayer:CCScaledLayer;
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

			uiLayer = new CCScaledLayer();
			
			//var renderer = new Renderer("assets/logo.png", 240, 240, 1, 0);
			//uiLayer.addChild(renderer.sprite);
			
			Cocos2D.addLayer(uiLayer);
			SimpleAudioEngine.sharedEngine().preloadEffect("assets/tank.mp3");

            spawnPlayer(240, 240);

            //spawnMonsterEntity(300,300);

			
			timeManager.addTickedObject(this);
		}
		
		public function isCollidingWithWorld(x:Number, y:Number):boolean 
		{

				var tile:CCSize = map.getTileSize();
			
				var p:CCPoint = new CCPoint(Math.floor(x / tile.width), Math.floor(map.getMapSize().height - (y / tile.height)));
				
				var tileNum:Number = collide.tileGIDAt(p);
				
				return tileNum != 0;
				//return false;

		}
		
		public function spawnPlayer(x:Number, y:Number)
		{
		
			var renderer = new Renderer("assets/sprites/tankBase.png", x, y, 1, 0);
			layer.addChild(renderer.sprite);
		
			var tRenderer = new Renderer("assets/sprites/tankTurret.png", x, y, 1, 0);
			layer.addChild(tRenderer.sprite);
			
			var e = new Tank(this, x, y, renderer, .5, .5, 200, tRenderer, 100, 50, 300, 1, 2, 0, 0); 
			dynamicEntityList.push(e);
			
			var control = new PlayerController(this, e, layer, uiLayer);
			controllerList.push(control);
			
			following = e;
			moveCamera();

		}
		
		public function dynamicCollides(object:DynamicEntity):DynamicEntity{
		
			for(var i:int = 1; i < dynamicEntityList.length; i++)
			{
				if (object.isCollidingWithDynamic(dynamicEntityList[i])&&(object!=dynamicEntityList[i]))
					return dynamicEntityList[i];
			}
			return null; 

		}
		
		public function spawnMonsterEntity(x:Number, y:Number){
			var renderer = new Renderer("assets/sprites/enemy.png", x, y, .5, 0);
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
			worldList.push(e);
		}
		
		public function removeEntity(e:Entity)
		{
			dynamicEntityList.remove(e);
 			worldList.remove(e);
			layer.removeChild(e.renderer.sprite);
				
			for(var i:int = 0; i < controllerList.length; i++) {
				if(controllerList[i].controllerOf(e as DynamicEntity)) {
					controllerList.remove(i);
					break;
				}
			}
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
			
			/*
			totalTime+=dt;
			
			
			timeTillNextSpawn-=dt;
			if (timeTillNextSpawn<0){
				
				spawnMonsterEntity(600,300);
				timeTillNextSpawn=5;
			}
			
			if (timeTillNextSpawn<0)
			{
				
				spawnMonsterEntity(550,550);
				timeTillNextSpawn=2.5;
			}
			*/
			
			for(var i:int = 0; i < controllerList.length; i++) {
				controllerList[i].update();
			}
			
			for(var j:int = 0; j < dynamicEntityList.length; j++) {
				dynamicEntityList[j].update(dt);
			}
			
			for(var k:int = 0; k < worldList.length; k++) {
				worldList[k].update(dt);
			}
			
			moveCamera();
		}
		

	}

}
