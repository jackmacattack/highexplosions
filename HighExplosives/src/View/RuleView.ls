package HighExplosives.View
{   

    import Loom.GameFramework.*;
    import cocos2d.*;
 
    import HighExplosives.*;
    
    import UI.Label;
 	
    import Loom.GameFramework.TimeManager;
    
    import HighExplosives.*;
    
    import HighExplosives.View.*;
    import HighExplosives;
    
    

    public class RuleView extends View
    {
    
    
    	public function RuleView(gm:HighExplosives)
    	{
        	super(gm);
        
        }
    

    	
    	
    	
        override public function  start(layer_:CCScaledLayer)
        {
        
        
         	layer=layer_;

            var bg = CCSprite.createFromFile("assets/bg.png");
            bg.x = Cocos2D.getDisplayWidth() / 2;
            bg.y = Cocos2D.getDisplayHeight() / 2;
            bg.scale = 0.5;
            layer.addChild(bg);
            
             var button = CCSprite.createFromFile("assets/Rules.png");
            button.x = Cocos2D.getDisplayWidth() / 2;
            button.y = Cocos2D.getDisplayHeight() / 2;
            button.onTouchBegan += goMainMenu;
            button.scale = 0.6;
            layer.addChild(button);
            

          
           
           
            
            }
        
         public function goMainMenu(){
         
         	   gameManager.mainMenu(layer);
         	
          
         }
       
        
      
      
        
       
       
    }
}