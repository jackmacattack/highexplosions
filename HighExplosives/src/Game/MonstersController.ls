package HighExplosives.Game
{

	import cocos2d.CCPoint;

	import Loom.GameFramework.TickedComponent;
	
	
	public class MonstersController extends Controller {
		
  		
  		
  		public var tapped:boolean = false;
  		public var player:DynamicEntity; 
  		
  		public var distanceToMove: Number = 1000;
  		public var distanceToIntercept: Number = 150;
  		
  		public var sizeOfSquare = 100;
  		
  		public var count:Number;
  		
  		
  		
		public function MonstersController(level_:HiExLevel, e_:DynamicEntity,player_:DynamicEntity) 
		{
			super(level_, e_);
			player=player_;
			
			e.setTarget(this.e.getX()+sizeOfSquare,this.e.getY());
			
		}
		
		//squared distance 
		override public function update() 
		{
			/*if((e as MonsterEntity).explosion) {
				(e as MonsterEntity).explode();
				return;
			}*/
			
			var dist:Number = Utils.calculateDistance(player.getX(),player.getY(),this.e.getX(),this.e.getY());
			
			if(dist > distanceToMove * distanceToMove){
				//this.e.setTarget(e.getX(), e.getY());
			}
			else if(dist < distanceToIntercept * distanceToIntercept){

				this.e.setTarget(player.getX(),player.getY());
			}
			else
				followPath();	
		}
		
		public function followPath()
		{
			if (this.e.distanceToTarget()<5)
			{
				if(count==0){
					
					this.e.setTarget(this.e.getX()+sizeOfSquare,this.e.getY());
					count++;
				}
				else if (count == 1){
					
					this.e.setTarget(this.e.getX(),this.e.getY()+sizeOfSquare);
					count++;
					
				}
				else if (count == 2)
				{
					
					this.e.setTarget(this.e.getX()-sizeOfSquare,this.e.getY());
					count++;
				}
				else 
				{
							
					this.e.setTarget(this.e.getX(),this.e.getY()-sizeOfSquare);
					count=0;
				}
			}
			
		}
	
	}
}
