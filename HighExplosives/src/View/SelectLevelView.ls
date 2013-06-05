package HighExplosives.View
{   

  	import Loom.GameFramework.*;
    import cocos2d.*;
    import HighExplosives.*;
	import HighExplosives;
	
    public class SelectLevelView extends View
    
    {
        
        public function SelectLevelView(gm:HighExplosives){
        	super(gm);
        }
        
        override public function  start(layer_:CCScaledLayer):void
        {
        
        	super.start(layer_);
        	layer=layer_;
       	 var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 0.5;
            layer.addChild(bg);
            
          var leval_1 = CCSprite.createFromFile("assets/Leval_1.png");
              leval_1.x = Cocos2D.getDisplayWidth() / 2;
              leval_1.y = 3 * Cocos2D.getDisplayHeight() / 4;
              leval_1.onTouchBegan += goLevel_1;
              layer.addChild(leval_1);
            
            var back = CCSprite.createFromFile("assets/back.png");
            back.x = 55*Cocos2D.getDisplayWidth() / 100;
            back.y = Cocos2D.getDisplayHeight() / 5;
            back.onTouchBegan += goMainMenu;
            back.scale = 0.75;
            layer.addChild(back);
        
        }
        
        
        public function goLevel_1(){
        
        
       		gameManager.gameView(layer,1);
       	  
       		 
        }
        
         public function goMainMenu(){
         
         	   gameManager.mainMenu(layer);
         	
          
         }
       
    }
}