package HighExplosives.View
{   

    import cocos2d.CCNode;
    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;
    
    import HighExplosives.Game.*;
    import Loom.GameFramework.TimeManager;
    
    import UI.Label;
  //  import View.View;
    import UI.Label;

    public class GameView extends View
    {
    	public var timeManager:TimeManager;
    
    	public function GameView(timeManager_:TimeManager)
    	{
    		timeManager = timeManager_;
    	}
        override public function  start(layer:CCScaledLayer):void
        {
        
        	var level:HiExLevel = new HiExLevel(layer, timeManager);
        	level.initialize();
        	
        }
        
         public function goMainMenu(){
         	var  test  = new MainMenu(timeManager);
         	var testLayer = new CCScaledLayer();
        	Cocos2D.addLayer(testLayer);
        	test.start(testLayer);
         }
       
    }
}