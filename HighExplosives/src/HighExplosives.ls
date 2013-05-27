package
{
    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCSprite;
    import cocos2d.ScaleMode;

	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.LoomGameObject;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;

	import HighExplosives.Game.HiExLevel;

    import UI.Label;

    public class HighExplosives extends Cocos2DGame
    {
    
        
        override public function run():void
        {
        
            // Comment out this line to turn off automatic scaling.
            layer.scaleMode = ScaleMode.LETTERBOX;

            super.run();

			var level:HiExLevel = new HiExLevel(layer);

        }
    }
}