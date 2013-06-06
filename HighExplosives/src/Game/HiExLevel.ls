package HighExplosives.Game
{

    import Loom.GameFramework.*;
    import cocos2d.*;
	import CocosDenshion.SimpleAudioEngine;
	
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
		public var breakList:Vector.<Breakable> = new Vector.<Breakable>();
		
		public var killList:Vector.<Entity> = new Vector.<Entity>();
		
		public var totalTime:Number=0;
		public var xStart:Number;
		public var yStart:Number;
		public var endPortal:Portal;
		public var timeTillNextSpawn=3;
		public var monsterCount:Number=0;
		public var spawnPoint:Vector.<CCPoint> = new Vector.<CCPoint>();
		
		public var collideWithWorld:boolean = false;
		
		public var gameView: GameView ;
		
		public var pauseBoolean:boolean = true;
		
		public var stopGame :Renderer;
		public 	var theGameIsPause:Renderer;
		public var rule:Renderer;
		public var ruleButton:Renderer;
		public var resueme :Renderer;
		
		public var healthBar:Renderer;
		public var fullHealth:Number;
		
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
            
            var objGroups:CCArray = map.getObjectGroups();
            for (var groupCnt = 0; groupCnt < objGroups.count(); groupCnt++)
            {
            	var objGroup:CCTMXObjectGroup = objGroups.objectAtIndex(groupCnt) as CCTMXObjectGroup;
                var objs:CCArray = objGroup.getObjects();
                for (var objCnt = 0; objCnt < objs.count(); objCnt++)
                {
                	var obj:CCDictionary = objs.objectAtIndex(objCnt) as CCDictionary;

                    var objType:String = obj.valueForKey("type");
                    var objName:String = obj.valueForKey("name");
                    var objX:int = obj.valueForKey("x").toNumber();
                    var objY:int = obj.valueForKey("y").toNumber();
                    
                    if (objType == "start")
                    {
                    	var srenderer = new Renderer("assets/sprites/start.png", objX, objY, 1, 0);
						layer.addChild(srenderer.sprite);
						xStart = objX;
						yStart = objY;
                    }
                    else if (objType == "end")
                    {
                    	var erenderer = new Renderer("assets/sprites/end.png", objX, objY, 1, 0);
                    	layer.addChild(erenderer.sprite);
                    	
                    	endPortal = new Portal(this, objX, objY, erenderer);
                    	worldList.push(endPortal);
                    }
                    else if (objType == "smallrock")
                    {
                    	var rrenderer = new Renderer("assets/sprites/smallrock.png", objX+16, objY+16, 1, 0);
                    	layer.addChild(rrenderer.sprite);
                    	
                    	var r:Breakable = new Breakable(this, objX+16, objY+16, rrenderer);
                    	breakList.push(r);
                    }
                }
            }
            
            
            SimpleAudioEngine.sharedEngine().preloadBackgroundMusic("assets/Tribal.mp3");
            SimpleAudioEngine.sharedEngine().setBackgroundMusicVolume(0.0);
			SimpleAudioEngine.sharedEngine().playBackgroundMusic("assets/Tribal.mp3", true);
			
			spawnPoint.push(new CCPoint(576,416), new CCPoint(480,384), new CCPoint(384,416), new CCPoint(256,416), new CCPoint(672,256));
			spawnPoint.push(new CCPoint(576,224), new CCPoint(512,256), new CCPoint(416,224), new CCPoint(256,32), new CCPoint(416,96));
			spawnPoint.push(new CCPoint(800,64), new CCPoint(832,224), new CCPoint(832,416), new CCPoint(1024,384), new CCPoint(1056,256));
			spawnPoint.push(new CCPoint(1024,96), new CCPoint(1376,416), new CCPoint(1472,352), new CCPoint(1408,256), new CCPoint(1376,96));
			spawnPoint.push(new CCPoint(1504,64), new CCPoint(1504,288), new CCPoint(1920,224), new CCPoint(1984,416), new CCPoint(2112,224));


			uiLayer = new CCScaledLayer();
			
			var pauseButton = new Renderer("assets/Pause.png", 25, 15, 1, 0);
			pauseButton.sprite.onTouchBegan += goPauseBotton;
			uiLayer.addChild(pauseButton.sprite);
			
			Cocos2D.addLayer(uiLayer);
			SimpleAudioEngine.sharedEngine().preloadEffect("assets/tank.mp3");

            spawnPlayer(xStart, yStart);

            spawnMonsterEntity(554,416);
			
			var redBar:Renderer = new Renderer("assets/sprites/death.png", Cocos2D.getDisplayWidth(),10,1,0);
			healthBar = new Renderer("assets/sprites/health.png", Cocos2D.getDisplayWidth(),10,1,0);
			fullHealth = healthBar.sprite.getContentSize().width;
			
			uiLayer.addChild(redBar.sprite);
			uiLayer.addChild(healthBar.sprite);
			
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
		
		public function spawnPlayer(x:Number, y:Number)
		{
		
			var renderer = new Renderer("assets/sprites/tankBase.png", x, y, 1, 0);
			layer.addChild(renderer.sprite);
		
			var tRenderer = new Renderer("assets/sprites/tankTurret.png", x, y, 1, 0);
			layer.addChild(tRenderer.sprite);
			

			var e = new Tank(this, x, y, renderer, .9, .5, 200, tRenderer, 100, 50, 300, 1, 2, 10, 2); 

			dynamicEntityList.push(e);
			
			var control = new PlayerController(this, e, layer, uiLayer);
			controllerList.push(control);
			
			following = e;
			moveCamera();

		}
		
		public function spawnMonsterEntity(x:Number, y:Number){
			var renderer = new Renderer("assets/sprites/enemy.png", x, y, .5, 0);
			layer.addChild(renderer.sprite);
			
			var e = new MonsterEntity(this, x, y, renderer, 1); 
			dynamicEntityList.push(e);
			
			var control = new MonstersController(this, e, dynamicEntityList[0]);
			controllerList.push(control);
			
			monsterCount++;
			//trace("Monster Count: " + monsterCount);
			
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
			
			var e:Explosion = new Explosion(this, x, y, renderer, 1, owner, duration, damage, area);
			worldList.push(e);
		}
		
		public function spawnMonsterDeath(x:Number, y:Number, owner:Entity, duration:Number, damage:Number, area:Number)
		{

			if(killList.contains(owner)) {
				return;
			}
			
			var renderer = new Renderer("assets/bombex1.png", x, y, area, 0);
			layer.addChild(renderer.sprite);
			
			var e:Explosion = new Explosion(this, x, y, renderer, 1.2, owner, duration, damage, area);
			worldList.push(e);
			
			monsterCount--;
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
 			breakList.remove(e);
 			
			layer.removeChild(e.renderer.sprite);
			
			for(var i:int = 0; i < controllerList.length; i++) {
				if(controllerList[i].controllerOf(e as DynamicEntity)) {
					controllerList.remove(i);
					break;
				}
			}
			
				
		}
		
		private function moveCamera()
		{
		
			if(following == null) {
				return; 
			}
			
			layer.x = -1 * (following.getX()-Cocos2D.getDisplayWidth() / 2);
			layer.y = -1 * (following.getY()-Cocos2D.getDisplayHeight() / 2);
		
		}
		
		private function collisions() 
		{
			for(var i:int = 0; i < dynamicEntityList.length-1; i++)
			{
				
				for(var j:int = i+1; j < dynamicEntityList.length; j++)
				{
					
					if(dynamicEntityList[i].isColliding(dynamicEntityList[j])) {
					
						dynamicEntityList[i].resetMovement();
						dynamicEntityList[j].resetMovement();
						
						dynamicEntityList[i].onCollision(dynamicEntityList[j]);
						dynamicEntityList[j].onCollision(dynamicEntityList[i]);
					}
				}
				
				for(var k:int = 0; k < worldList.length; k++)
				{
					if (worldList[k].isColliding(dynamicEntityList[i])) {
						worldList[k].onCollision(dynamicEntityList[i]);
					}
				}
				
				for(var l:int = 0; l < breakList.length; l++) {
				
					if (breakList[l].isColliding(dynamicEntityList[i])) {
						dynamicEntityList[i].resetMovement(); 
					}
				}
			}
			for(var m:int = 0; m < breakList.length; m++) {
			
				for(var n:int = 0; n < worldList.length; n++)
				{
					if (worldList[n].isColliding(breakList[m])) {
						breakList[m].destroy();
					}
				}
			}
		}
		
		public function randomSpawn():CCPoint
		{
			var index:Number = Math.floor(Math.random()*spawnPoint.length);
			return spawnPoint[index];
		}
		
		override public function onTick() 
		{
			var dt:Number = timeManager.TICK_RATE; 
			
			totalTime+=dt;
			
			var point:CCPoint = new CCPoint;
			point = randomSpawn();
			var spawnX = point.x;
			var spawnY = point.y;
			
			timeTillNextSpawn-=dt;
			
			if (timeTillNextSpawn<0 && monsterCount<50){
				
				
				if (!isCollidingWithWorld(spawnX,spawnY))
				{
					//trace("spawn");

					spawnMonsterEntity(spawnX,spawnY);
					timeTillNextSpawn=3;
				}
			
			}
			
			collisions();
			
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
				
				resueme = new Renderer("assets/resume.png", Cocos2D.getDisplayWidth()/2, 10*Cocos2D.getDisplayHeight()/100 , 1, 0);
				resueme.sprite.onTouchBegan += goResume;
				uiLayer.addChild(resueme.sprite);
			}
			else
			{	
				uiLayer.removeChild(stopGame.sprite);
				uiLayer.removeChild(theGameIsPause.sprite);
				uiLayer.removeChild(ruleButton.sprite);
				uiLayer.removeChild(resueme.sprite);
				resume();
				pauseBoolean = true;	
			}
		}
		
		public function goResume(){
			goPauseBotton();
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
		
		public function onWin() {
			layer.cleanup();
			Cocos2D.removeLayer(this.layer);
			Cocos2D.removeLayer(uiLayer);
			SimpleAudioEngine.sharedEngine().stopAllEffects();
			timeManager.removeTickedObject(this);
			
			this.gameView.goWinView();
		
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
		
		public function updateHealthBar(percent:Number)
		{
			Console.print(percent + "," + fullHealth * percent);
			healthBar.scaleX = percent;
		}
	}

}
