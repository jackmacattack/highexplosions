package HighExplosives.Game
{

	public class Utils 
	{
		public static function calculateAngle(x2:Number, y2:Number, x1:Number = 0, y1:Number = 0):Number
		{
		
			var aTan = Math.atan(Math.abs((y2 - y1)/(x2 - x1)));
			
			var xCheck = x1 < x2;
			var yCheck = y1 < y2;
			
			if(xCheck && yCheck) {
				return aTan;
			}
			else if(xCheck) {
				return 2 * Math.PI - aTan;
			}
			else if(yCheck) {
				return Math.PI - aTan;
			}
			else {
				return Math.PI + aTan;
			}
			
		}
		public static function calculateDistance(x2:Number, y2:Number, x1:Number, y1:Number):Number
		{
			return (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
		}
	}	
}