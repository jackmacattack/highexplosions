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
    import System.Math;
    
    import Loom.GameFramework.*;
    import cocos2d.*;
   
    import HighExplosives.*;

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
    
    import HighExplosives.View.GameView;
    
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
		
		public var killList:Vector.<Entity> = new Vector.<Entity>();
		
		public var totalTime:Number=0;
		
		public var timeTillNextSpawn=3;
		
		public var collideWithWorld:boolean = false;
		
		public var gameView: GameView ;
		
		public var pauseBoolean:boolean = true;
		
		public var stopGame :Renderer;
		public 	var theGameIsPause:Renderer;
		public var rule:Renderer;
		public var ruleButton:Renderer;
		
		
		public function HiExLevel(layer_:CCScaledLayer, timeManager_:TimeManager, gameView_: GameView) 
		{
			layer = layer_;
			timeManager = timeManager_;
			gameView= gameView_;
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
			
			var pauseButton = new Renderer("assets/Pause.png", 25, 15, 1, 0);
			pauseButton.sprite.onTouchBegan += goPauseBotton;
			uiLayer.addChild(pauseButton.sprite);
			
			Cocos2D.addLayer(uiLayer);
			SimpleAudioEngine.sharedEngine().preloadEffect("assets/tank.mp3");

            spawnPlayer(240, 240);

			for(var i:int = 0; i < 10; i++) {
            	
				var spawnX = map.getContentSize().width*Math.random();
				var spawnY = map.getContentSize().height*Math.random();
            	spawnMonsterEntity(spawnX,spawnY);
            }
			
			timeManager.addTickedObject(this);
		}
		
		public function isCollidingWithWorld(x:Number, y:Number):boolean 
		{

				var tile:CCSize = map.getTileSize();
			
				var p:CCPoint = new CCPoint(Math.floor(x / tile.width), Math.floor(map.getMapSize().height - (y / tile.height)));
				
				var tileNum:Number = collide.tileGIDAt(p);
				collideWithWorld = true;
				return tileNum != 0;
				//return false;

		}
		
		public function dynamicCollides(object:DynamicEntity):DynamicEntity{
		
			for(var i:int = 0; i < dynamicEntityList.length; i++)
			{
				if(object == dynamicEntityList[i]) {
					continue;
				}
				
				if (object.isColliding(dynamicEntityList[i]))
					return dynamicEntityList[i];
			}
			return null; 

		}
		
		public function worldCollides(object:DynamicEntity):Vector.<Entity>{
		
			var vec:Vector.<Entity> = new Vector.<Entity>();
		
			for(var i:int = 0; i < worldList.length; i++)
			{
				if (worldList[i].isColliding(object))
					vec.push(worldList[i]);
			}
			
			return vec; 

		}
		
		public function spawnPlayer(x:Number, y:Number)
		{
		
			var renderer = new Renderer("assets/sprites/tankBase.png", x, y, 1, 0);
			layer.addChild(renderer.sprite);
		
			var tRenderer = new Renderer("assets/sprites/tankTurret.png", x, y, 1, 0);
			layer.addChild(tRenderer.sprite);
			

			var e = new Tank(this, x, y, renderer, .5, 200, tRenderer, 100, 50, 300, 1, 2, 0, 0); 

			dynamicEntityList.push(e);
			
			var control = new PlayerController(this, e, layer, uiLayer);
			controllerList.push(control);
			
			following = e;
			moveCamera();

		}
		
		public function spawnMonsterEntity(x:Number, y:Number){
			var renderer = new Renderer("assets/sprites/enemy.png", x, y, .5, 0);
			layer.addChild(renderer.sprite);
			
			var e = new MonsterEntity(this, x, y, renderer); 
			dynamicEntityList.push(e);
			
			var control = new MonstersController(this, e, dynamicEntityList[0]);
			controllerList.push(control);
			
		}
		
		public function spawnTestExplosive(x:Number, y:Number, owner:Entity, speed:Number, angle:Number, time:Number, duration:Number, damage:Number, area:Number)
		{
		
			var renderer = new Renderer("assets/bomb1.png", x, y, 1, 0);
			layer.addChild(renderer.sprite);
			
			var e:Explosive = new Explosive(this, x, y, renderer, owner, speed, angle, time, duration, damage, area);
			dynamicEntityList.push(e);
		
		}
		
		public function spawnExplosion(x:Number, y:Number, owner:Entity, duration:Number, damage:Number, area:Number)
		{
		
			var renderer = new Renderer("assets/bombex2.png", x, y, area, 0);
			layer.addChild(renderer.sprite);
			
			var e:Explosion = new Explosion(this, x, y, renderer, owner, duration, damage, area);
			worldList.push(e);
		}
		
		public function spawnMonsterDeath(x:Number, y:Number, owner:Entity, duration:Number, damage:Number, area:Number)
		{
				var renderer = new Renderer("assets/bombex1.png", x, y, area, 0);
				layer.addChild(renderer.sprite);
				
				var e:Explosion = new Explosion(this, x, y, renderer, owner, duration, damage, area);
				worldList.push(e);
		}
		
		public function addToKill(e:Entity) {
			if(!killList.contains(e))
				killList.push(e);
				
				//removeEntity(e);
		}
		
		private function removeEntity(e:Entity)
		{
			if(e == null) {
				return;
			}
			
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
			
			totalTime+=dt;
			
			
			var spawnX = map.getContentSize().width*Math.random();
			var spawnY = map.getContentSize().height*Math.random();
			
			timeTillNextSpawn-=dt;
			
			if (timeTillNextSpawn<0){
				
				
				if (!isCollidingWithWorld(spawnX,spawnY))
				{
					trace("spawn");
					spawnMonsterEntity(spawnX,spawnY);
					timeTillNextSpawn=3;
				}
			
			}
			
			for(var i:int = 0; i < controllerList.length; i++) {
				controllerList[i].update();
			}
			
			for(var j:int = 0; j < dynamicEntityList.length; j++) {
				dynamicEntityList[j].update(dt);
			}
			
			for(var k:int = 0; k < worldList.length; k++) {
				worldList[k].update(dt);
			}
			
			for(var l:int = 0; l < worldList.length; l++) {
				removeEntity(killList[l]);
				//killList.remove(l);
			}
			killList.clear();
			
			moveCamera();
			//Console.print("afd");
		}
		
		public function pause(){
			timeManager.stop();
		}
		
		public function resume(){
			
			timeManager.start();
		}
		
		public function goPauseBotton(){

			if(pauseBoolean)
			{
				SimpleAudioEngine.sharedEngine().stopAllEffects();
				pause();
				pauseBoolean=false;
				
			    stopGame = new Renderer("assets/endTheGame.png", Cocos2D.getDisplayWidth()/2, Cocos2D.getDisplayHeight()/2 , 1, 0);
    	        stopGame.sprite.onTouchBegan += goEndGame;
            	uiLayer.addChild(stopGame.sprite);
            	
                 theGameIsPause = new Renderer("assets/gamePause.png", Cocos2D.getDisplayWidth()/2, 3*Cocos2D.getDisplayHeight()/4 , 1, 0);
				uiLayer.addChild(theGameIsPause.sprite);
				
				ruleButton = new Renderer("assets/rulesbutton.png", Cocos2D.getDisplayWidth()/2, Cocos2D.getDisplayHeight()/4 , 1, 0);
				ruleButton.sprite.onTouchBegan += goRule;
				uiLayer.addChild(ruleButton.sprite);
			}
			else
			{	
				uiLayer.removeChild(stopGame.sprite);
				uiLayer.removeChild(theGameIsPause.sprite);
				uiLayer.removeChild(ruleButton.sprite);
				resume();
				pauseBoolean = true;	
			}
		}
		
		public function goEndGame(){
			endGame();
		}
		
		public function goRule(){
			uiLayer.removeChild(stopGame.sprite);
			uiLayer.removeChild(theGameIsPause.sprite);
			uiLayer.removeChild(ruleButton.sprite);
			rule = new Renderer("assets/Rules.png", Cocos2D.getDisplayWidth()/2, Cocos2D.getDisplayHeight()/2 , .5, 0);
			rule.sprite.onTouchBegan += goPause;
			uiLayer.addChild(rule.sprite);
		}
		
		public function goPause()
		{
			pauseBoolean= true;
			uiLayer.removeChild(rule.sprite);
			 goPauseBotton();
		
		}
		
		public function endGame() {
			//timeManager.stop();
			layer.cleanup();
			Cocos2D.removeLayer(this.layer);
			Cocos2D.removeLayer(uiLayer);
			SimpleAudioEngine.sharedEngine().stopAllEffects();
			timeManager.removeTickedObject(this);
			
			this.gameView.goGameOver();
			
		}
		

	}

}
