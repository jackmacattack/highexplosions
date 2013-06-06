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
    	
    	 var gameLayer:CCScaledLayer;
    
    	public function GameView(gm:HighExplosives,timeManager_:TimeManager)
    	{
    		super(gm);
    		timeManager = timeManager_;
    	}
        override public function  start(layer:CCScaledLayer):void
        {
        	 var gameLayer:CCScaledLayer = new CCScaledLayer();
        	  Cocos2D.addLayer(gameLayer);
        	var level:HiExLevel = new HiExLevel(gameLayer, timeManager,this);
        	level.initialize();
        	
        }
        
         public function goMainMenu(){
         	gameManager.mainMenu(layer);
         }
         
         
         public function goGameOver()
         {
         	gameManager.gameOver(this.layer);
         }
         
         public function goWinView()
         {
         	gameManager.win(layer);
         }
       
    }
}