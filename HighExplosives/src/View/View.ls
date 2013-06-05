package HighExplosives.View
{
    import Loom.GameFramework.*;
    import cocos2d.*;
    import HighExplosives.*;
    import HighExplosives;
    
    import UI.Label;

    //public delegate ViewCallback():void;

    /**
     * Base view class; convenience callbacks to trigger transitions and 
     * sequence adding/removing from parent.
     */
    class View extends CCNode
    {
       // public var onEnter:ViewCallback;
       // public var onExit:ViewCallback;
        protected var layer:CCScaledLayer;
        public var gameManager:HighExplosives;
        //[Inject]
    	//protected var timeManager:TimeManager;
        
        public function View(gameManager_:HighExplosives){
        	gameManager=gameManager_;
        } 
        

        public function start(layer_:CCScaledLayer):void
        {
        		
        }

    }
}