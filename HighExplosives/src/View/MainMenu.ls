package HighExplosives.View
{   

    import Loom.GameFramework.TimeManager;
    import cocos2d.CCNode;
    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;
    import UI.Label;
 	import HighExplosives.View.MainMenu;
    import UI.Label;

    public class MainMenu extends View
    {
    
    	public var timeManager:TimeManager;
    	
    	public function MainMenu(timeManager_:TimeManager)
    	{
    		timeManager = timeManager_;
    	}
    	
        override public function  start(layer:CCScaledLayer)
        {
        
         
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
        
       		 var testLayer = new CCScaledLayer();
        		Cocos2D.addLayer(testLayer);
       		 var  test  = new GameView(timeManager);
       		 test.start(testLayer);
       		 
        	trace("Begin");
        }
      
        
        public function goSelectLevel():void {
       		 
       		 trace("SelectLevel");
       		 
       		 var testLayer = new CCScaledLayer();
        		Cocos2D.addLayer(testLayer);
       		 var  test  = new SelectLevelView();
       		 test.start(testLayer);
        
        }
        
        public function gohighScore(){
        	trace("HighScore");
        }
        
      
        
       
       
    }
}