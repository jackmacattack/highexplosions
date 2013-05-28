package
{
    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCSprite;
    import cocos2d.ScaleMode;
   // import View.View;
    import HighExplosives.View.MainMenu;
    import UI.Label;

    public class HighExplosives extends Cocos2DGame
    {
        override public function run():void
        {
        
        
        	super.run();
        	var  test  = new MainMenu();
        	test.start(this.layer);
        	
        	}
       
       
    }
}