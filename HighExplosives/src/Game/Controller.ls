package HighExplosives.Game
{

	import Loom.GameFramework.TickedComponent;
	 
	public class Controller {
	
		//The level the controller is in
		protected var level:HiExLevel;
		
		//The entity the controller operates on
		protected var e:DynamicEntity;
		
		public function Controller(level_:HiExLevel, e_:DynamicEntity) 
		{
			level = level_;
			e = e_;
		}
		
		public function controllerOf(e_:DynamicEntity):boolean 
		{
			return e == e_;
		}
		
		//Pseudo-abstract method. Called every tick to update entity state
		public function update() {}
	
	}

}