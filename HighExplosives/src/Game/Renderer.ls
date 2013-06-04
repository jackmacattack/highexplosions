package HighExplosives.Game
{
    import cocos2d.CCSprite;
    import cocos2d.CCSpriteFrame;
    import cocos2d.CCSpriteFrameCache;
    import cocos2d.CCNode;
    import Loom.GameFramework.AnimatedComponent;

    public class Renderer extends AnimatedComponent
    {
    
        public var sprite:CCSprite;         ///< The sprite that the class must render.
        
        public function Renderer(name:String, x:Number, y:Number, scale:Number, rotation:Number) // (__texture:String, nodeParent:CCNode)
        {

			sprite = CCSprite.createFromFile(name);
			
			sprite.setPositionX(x);
			sprite.setPositionY(y);
			
			sprite.setScaleX(scale);
			sprite.setScaleY(scale);
        }

        /**
         * Built in setter to propagate x position value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set x(value:Number):void
        {
            if(sprite)
                sprite.setPositionX(value);
        }

        /**
         * Built in setter to propagate y position value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set y(value:Number):void
        {
            if(sprite)
                sprite.setPositionY(value);
                
        }

        /**
         * Built in setter to propagate scale value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set scaleX(value:Number):void
        {
            if(sprite)
                sprite.setScaleX(value);
        }

        /**
         * Built in setter to propagate scale value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set scaleY(value:Number):void
        {
            if(sprite)
                sprite.setScaleY(value);
        }
        /**
         * Built in setter to propagate scale value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set scale(value:Number):void
        {
			scaleX = value;
			scaleY = value;
        }


        /**
         * Built in setter to propagate rotation value changes for data binding as a component.
         *
         * @param   value:Number    The value to set.
         */
        public function set rotation(value:Number):void
        {
            if(sprite)
                sprite.setRotation((-1 * value + Math.PI / 2) / Math.PI * 180);
        }

    }
}