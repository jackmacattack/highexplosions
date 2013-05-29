package HighExplosives.Game
{

	import cocos2d.CCPoint;

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
  		
		public function PlayerController(level_:HiExLevel, e_:DynamicEntity, gestureManager_:GestureManager) 
		{
			super(level_, e_);
			
			gestureManager = gestureManager_;
			gestureManager.onGestureSwipe += onGestureSwipe;
			gestureManager.onGestureDoubleTap += onGestureDoubleTap;
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
				(e as TestEntity).throwBomb(mag, angle);
				swiped = false;
			}
			
		}
	
        public function onGestureDoubleTap(data:GestureDelegateData)
        {
			tap = data.positionDelta.toPoint;
			tapped = true;
        }
        
        public function onGestureSwipe(data:GestureDelegateData)
        {
			swipe = data.positionDelta.deltaPoint;
			swiped = true;
        }
         
	}

}