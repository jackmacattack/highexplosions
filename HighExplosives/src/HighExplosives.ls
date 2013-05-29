package
{
    import Loom.GameFramework.TimeManager;
    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCSprite;
    import cocos2d.ScaleMode;
   // import View.View;
    import HighExplosives.View.MainMenu;
    import UI.Label;

    public class HighExplosives extends Cocos2DGame
    {
    
    	[Inject]
    	public var timeManager:TimeManager;
    
        override public function run():void
        {
            
            super.run();
        	var  test  = new MainMenu(timeManager);
        	test.start(this.layer);
        	
        }
        	 
    }
}
