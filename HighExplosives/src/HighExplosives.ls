package
{
    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;

	import Loom.GameFramework.LoomGroup;
	import Loom.GameFramework.LoomGameObject;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;

	import HighExplosives.Game.HiExLevel;

    import UI.Label;

    public class HighExplosives extends Cocos2DGame
    {
    
		[Inject]
		public var timeManager:TimeManager;
		
		//[Inject]
		//public var group:LoomGroup;
		
        public var level:HiExLevel;
        
        override public function run():void
        {
        
            // Comment out this line to turn off automatic scaling.
            layer.scaleMode = ScaleMode.LETTERBOX;

			var gameField:CCScaledLayer = new CCScaledLayer();
			Cocos2D.addLayer(gameField);

			level = new HiExLevel(gameField);
			//level.owningGroup = group;
			level.initialize();
            super.run();
        }
        
        
        override public function onTick()
        {
			var dt:Number = timeManager.TICK_RATE; 
        	level.move(dt);
        }
    }
}