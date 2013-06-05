package HighExplosives.View
{   

    import cocos2d.CCNode;
    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;
    
    import HighExplosives.Game.*;
    import Loom.GameFramework.TimeManager;
    
    import HighExplosives;
    
    import UI.Label;
  //  import View.View;
    import UI.Label;

    public class GameView extends View
    {
    	public var timeManager:TimeManager;
    
    	public function GameView(gm:HighExplosives,timeManager_:TimeManager)
    	{
    		super(gm);
    		timeManager = timeManager_;
    	}
        override public function  start(layer:CCScaledLayer):void
        {
        
        	var level:HiExLevel = new HiExLevel(layer, timeManager,this);
        	level.initialize();
        	
        }
        
         public function goMainMenu(){
         	gameManager.mainMenu(layer);
         }
         /*
         
         public function goGameOver()
         {
         	gameManager.GameOver(this.layer);
         }
       */
    }
}