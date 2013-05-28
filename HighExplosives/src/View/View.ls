package HighExplosives.View
{
    import cocos2d.CCNode;
    import cocos2d.Cocos2D;
    import cocos2d.CCSprite;
    import cocos2d.CCScaledLayer;
    import cocos2d.ScaleMode;
    import UI.Label;

    public delegate ViewCallback():void;

    /**
     * Base view class; convenience callbacks to trigger transitions and 
     * sequence adding/removing from parent.
     */
    class View extends CCNode
    {
        public var onEnter:ViewCallback;
        public var onExit:ViewCallback;

        public function start(layer:CCScaledLayer):void
        {
            
        }

        public function exit():void
        {
            if(getParent())
            {
                getParent().removeChild(this);
                onExit();
            }
        }

    }
}