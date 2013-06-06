package HighExplosives.View
{   

  	import Loom.GameFramework.*;
    import cocos2d.*;
    import HighExplosives.*;
	import HighExplosives;
	
    public class GameOverView extends View
    
    {
        
        public function GameOverView(gm:HighExplosives){
        	super(gm);
        	
        }
        
        override public function  start(layer_:CCScaledLayer):void
        {
        
        	super.start(layer_);
        	layer=layer_;
       	 var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 1;
            layer.addChild(bg);
            
          var gameOver = CCSprite.createFromFile("assets/GameOver.png");
              gameOver.x = Cocos2D.getDisplayWidth() / 2;
              gameOver.y = 3 * Cocos2D.getDisplayHeight() / 4;
              
              layer.addChild(gameOver);
            
            var back = CCSprite.createFromFile("assets/back.png");
            back.x = 55*Cocos2D.getDisplayWidth() / 100;
            back.y = Cocos2D.getDisplayHeight() / 5;
            back.onTouchBegan += goMainMenu;
            back.scale = 0.75;
            layer.addChild(back);
        
        }
        
        
         public function goMainMenu(){
         
         	   gameManager.mainMenu(layer);
         	
          
         }
       
    }
}