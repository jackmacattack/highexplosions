package HighExplosives.Game
{

	import cocos2d.CCPoint;

	import Loom.GameFramework.TickedComponent;
	
	import com.rmc.data.types.GestureManagerOptions;
    import com.rmc.managers.GestureManager;
    import com.rmc.data.types.GestureDelegateData;
    import com.rmc.applications.AbstractLoomDemo;
	
	public class MonstersController extends Controller {
		
  		
  		
  		public var tapped:boolean = false;
  		public var player:DynamicEntity; 
  		
		public function MonstersController(level_:HiExLevel, e_:DynamicEntity,player_:DynamicEntity) 
		{
			super(level_, e_);
			player=player_;
			
		}
		
		override public function update() 
		{
			e.setTarget(player.getX(), player.getY());
			
			
		}
	
       
         
	
	}
}