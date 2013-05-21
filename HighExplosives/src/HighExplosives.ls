package
{
    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCSprite;
    import cocos2d.ScaleMode;

    import UI.Label;

    public class HighExplosives extends Cocos2DGame
    {
        override public function run():void
        {
        
            // Comment out this line to turn off automatic scaling.
            layer.scaleMode = ScaleMode.LETTERBOX;

            super.run();

            // Setup anything else, like UI, or game objects.
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
            button.y = Cocos2D.getDisplayHeight() / 4;
            button.onTouchBegan += goBegin;
            button.scale = 0.25;
            layer.addChild(button);
        }
        
        public function goBegin()
        {
        	trace("Begin");
        }
    }
}