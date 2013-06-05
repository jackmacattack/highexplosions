package HighExplosives.Game {

	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	import cocos2d.CCSprite;
    import cocos2d.*;
    import cocos2d.CCNode;
    
    public class Portal extends Entity {
    	
    	public function Portal(level:HiExLevel, x:Number, y:Number, renderer:Renderer)
    	{
    		super(level, x, y, renderer);
    	}
    	
    	override public function isColliding(object:DynamicEntity):boolean
    	{
    		return boundingBoxCheck(object) && (object.controller instanceof PlayerController);
    	}
    
    	override public function onCollision(object:DynamicEntity)
    	{
    		level.onWin();
    	}
    }
}