package HighExplosives.Game
{

	import cocos2d.CCPoint;
	import cocos2d.CCScaledLayer;

	import Loom.GameFramework.TickedComponent;
	
	import com.rmc.data.types.GestureManagerOptions;
    import com.rmc.managers.GestureManager;
    import com.rmc.data.types.GestureDelegateData;
    import com.rmc.applications.AbstractLoomDemo;
	
	public class PlayerController extends Controller {
		
  		public var gestureManager:GestureManager;
  		
  		public var tapped:boolean = false;
  		public var tap:CCPoint;
  		
  		private var swiped:boolean = false;
  		public var swipe:CCPoint;
  		
  		public var score:Number=0; 
  		
		public function PlayerController(level_:HiExLevel, e_:Tank, layer:CCScaledLayer, uiLayer:CCScaledLayer) 
		{
			super(level_, e_);
			
  			gestureManager = new GestureManager(uiLayer);
			
			gestureManager.onGestureSwipe += onGestureSwipe;
			gestureManager.onGestureDoubleTap += onGestureDoubleTap;
			
			layer.onTouchBegan += onTouchBegan;
		}
		
		override public function update() 
		{
		
			if(tapped) {
				tapped = false;
				e.setTarget(tap.x, tap.y);
			}
			if(swiped) {
				var mag:Number = swipe.x * swipe.x + swipe.y * swipe.y;
				var angle:Number = Utils.calculateAngle(swipe.x, swipe.y);
				(e as Tank).throwBomb(mag, angle);
				swiped = false;
			}
			
			trace(score);
			
		}
	
        public function onGestureDoubleTap(data:GestureDelegateData)
        {
			tapped = true;
        }
        
        public function onGestureSwipe(data:GestureDelegateData)
        {
			swipe = data.positionDelta.deltaPoint;
			swiped = true;
        }
        
        public function onTouchBegan(id:Number, x:Number, y:Number) 
        {
        	tap = new CCPoint(x, y);
        }
	}

}