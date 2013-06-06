package HighExplosives.View
{   

    import Loom.GameFramework.*;
    import cocos2d.*;
    import CocosDenshion.SimpleAudioEngine;
    import HighExplosives.*;
    
    import UI.Label;
 	
    import Loom.GameFramework.TimeManager;
    
    import HighExplosives.*;
    
    import HighExplosives.View.*;
    import HighExplosives;
    
    

    public class MainMenu extends View
    {
    
    
    	public function MainMenu(gm:HighExplosives)
    	{
        	super(gm);
        	SimpleAudioEngine.sharedEngine().preloadBackgroundMusic("assets/Backstory.mp3");
        	SimpleAudioEngine.sharedEngine().preloadBackgroundMusic("assets/Tribal.mp3");
        	SimpleAudioEngine.sharedEngine().playBackgroundMusic("assets/Backstory.mp3");
        	trace(SimpleAudioEngine.sharedEngine().getBackgroundMusicVolume());
        

        }
    
    	//public var layer:CCScaledLayer;
    	//public var timeManager:TimeManager;
    	
    	
    	
        override public function  start(layer_:CCScaledLayer)
        {
        
        
        	 layer=layer_;
           layer.scaleMode = ScaleMode.LETTERBOX;

            var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 0.5;
            layer.addChild(bg);
            
            var sprite = CCSprite.createFromFile("assets/hiex.png");
            sprite.x = Cocos2D.getDisplayWidth() / 2;
            sprite.y = 3 * Cocos2D.getDisplayHeight() / 4;
            layer.addChild(sprite);

            var button = CCSprite.createFromFile("assets/button.png");
            button.x = Cocos2D.getDisplayWidth() / 2;
            button.y = 4*Cocos2D.getDisplayHeight() / 10;
            button.onTouchBegan += goBegin;
            button.scale = 0.25;
            layer.addChild(button);
            
            var selectLevel = CCSprite.createFromFile("assets/selectLevel.png");
            selectLevel.x = Cocos2D.getDisplayWidth() / 2;
            selectLevel.y = 3*Cocos2D.getDisplayHeight() / 10;
            selectLevel.onTouchBegan += goSelectLevel;
            selectLevel.scale = 0.25;
            layer.addChild(selectLevel);
           
             
     		var rules = CCSprite.createFromFile("assets/rulesbutton.png");
            rules.x = Cocos2D.getDisplayWidth() / 2;
            rules.y = 15*Cocos2D.getDisplayHeight() / 100;
            rules.onTouchBegan += goRules;
            rules.scale = 1;
            layer.addChild(rules);       
         
            
            
        	
        
        }
        
        public function goBegin()
        {
            SimpleAudioEngine.sharedEngine().stopBackgroundMusic(true);
        	gameManager.gameView(layer,1);
        	trace("Begin");
        	SimpleAudioEngine.sharedEngine().playBackgroundMusic("assets/Tribal.mp3");

        }
      
        
        public function goSelectLevel():void {
        
        	gameManager.selectLevel(layer);
       		 
       		 trace("SelectLevel");
       		
        
        }
        
        public function goRules():void {
        
        	gameManager.rules(layer);
        }
        
      
      
        
       
       
    }
}