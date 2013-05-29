package HighExplosives.View
{   

    import Loom.GameFramework.*;
    import cocos2d.*;
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
            
             var highScore = CCSprite.createFromFile("assets/highScore.png");
            highScore.x = Cocos2D.getDisplayWidth() / 2;
            highScore.y = Cocos2D.getDisplayHeight() / 5;
            highScore.onTouchBegan += gohighScore;
            highScore.scale = 0.25;
            layer.addChild(highScore);
            
            
            
            
        	
        
        }
        
        public function goBegin()
        {
        
        	gameManager.gameView(layer,1);
        	trace("Begin");
        }
      
        
        public function goSelectLevel():void {
        
        	gameManager.selectLevel(layer);
       		 
       		 trace("SelectLevel");
       		
        
        }
        
        public function gohighScore(){
        	trace("HighScore");
        }
        
      
        
       
       
    }
}