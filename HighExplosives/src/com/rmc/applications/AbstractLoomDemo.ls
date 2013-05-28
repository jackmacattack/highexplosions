/**
 * Copyright (C) 2005-2013 by Rivello Multimedia Consulting (RMC).                    
 * code [at] RivelloMultimediaConsulting [dot] com                                                  
 *                                                                      
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the      
 * "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish,  
 * distribute, sublicense, and#or sell copies of the Software, and to   
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:                                            
 *                                                                      
 * The above copyright notice and this permission notice shall be       
 * included in all copies or substantial portions of the Software.      
 *                                                                      
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR    
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.                                      
 */
// Marks the right margin of code *******************************************************************
package com.rmc.applications
{
	import cocos2d.CCVerticalTextAlignment;
	import cocos2d.CCTextAlignment;
	import cocos2d.ccColor3B;
	import cocos2d.CCTextFieldTTF;
    
    // --------------------------------------
    // Imports
    // --------------------------------------

    import cocos2d.Cocos2D;
    import cocos2d.Cocos2DGame;
    import cocos2d.CCLayer;
    import cocos2d.CCScaledLayer;
    import cocos2d.CCSprite;
    import cocos2d.ScaleMode;


    import com.rmc.templates.TemplateSingleton;
    import com.rmc.templates.ClassTemplate;
    import Loom.GameFramework.LoomGame;
    import UI.Label;

    import com.rmc.managers.GestureManager;
    import com.rmc.data.types.GestureDelegateData;

    // --------------------------------------
    // Class
    // --------------------------------------
    /**
     * This class is ...
     * 
     */
    class AbstractLoomDemo extends Cocos2DGame
    {

        // --------------------------------------
        // Properties
        // --------------------------------------
        // PUBLIC GETTER/SETTERS
        /**
         * Describe this member.
         * 
         */
        public static var _demoBackgroundCCSprite_ccsprite : CCSprite;  
        public static function get demoBackgroundCCSprite () : CCSprite { return _demoBackgroundCCSprite_ccsprite; }
        
        /**
         * Describe this member.
         * 
         */
        public var _demoLogoCCSprite_ccsprite : CCSprite;  
        public function get demoLogoCCSprite () : CCSprite { return _demoLogoCCSprite_ccsprite; }
      
        /**
         * Describe this member.
         * 
         */
        public var _demoLabel : Label;  
        public function get demoLabel () : Label { return _demoLabel; }
      
        /**
         * Describe this member.
         * 
         */
        public var _demoInstructions_cctextfieldttf :  CCTextFieldTTF
        public function get demoInstructionsCCTextFieldTTF () : CCTextFieldTTF { return _demoInstructions_cctextfieldttf; }
      
      
        /**
         * Describe this member.
         * 
         */
        public static var _Instance : AbstractLoomDemo;  
        public static function get Instance () : AbstractLoomDemo { return _Instance; }

        /**
         * Describe this member.
         * 
         */
        public function get width () : Number { return Cocos2D.getDisplayWidth(); }

        /**
         * Describe this member.
         * 
         */
        public function get height () : Number { return Cocos2D.getDisplayHeight(); }


        // PUBLIC CONST


        // PRIVATE
 
    

        // --------------------------------------
        // Constructor
        // --------------------------------------
        /**
         * This is the constructor.
         * 
         */
		public function AbstractLoomDemo () 
		{
		
		}

        // --------------------------------------
        // Methods
        // --------------------------------------
        // PUBLIC
        /**
         * Run
         * 
         * @return void
         * 
         */
        public function run():void 
        {
            // Pass control to root game.
            super.run();

            // STORE REFERENCE
            _Instance = this;

            // CREATE PRIMARY DRAWING LAYER FOR ALL GAME GRAPHICS
            layer.scaleMode = ScaleMode.LETTERBOX;

            // CREATE DEMO BACKGROUND
            _demoBackgroundCCSprite_ccsprite = CCSprite.createFromFile("./assets/images/bg.png");
            _demoBackgroundCCSprite_ccsprite.x = width/2;
            _demoBackgroundCCSprite_ccsprite.y = height/2;
            layer.addChild (_demoBackgroundCCSprite_ccsprite);
            
            // CREATE DEMO LOGO
            _demoLogoCCSprite_ccsprite = CCSprite.createFromFile("./assets/images/logo.png");
            _demoLogoCCSprite_ccsprite.x = width/2;
            _demoLogoCCSprite_ccsprite.y = height*0.35;
            layer.addChild (_demoLogoCCSprite_ccsprite); 

            
            // CREATE DEMO LABEL
            _demoLabel = new Label("./assets/fonts/Curse-hd.fnt");
            _demoLabel.scale = 0.5;
            _demoLabel.text = "Hello Loom!";
            _demoLabel.x = width/2;
            _demoLabel.y = _demoLogoCCSprite_ccsprite.y + _demoLogoCCSprite_ccsprite.getTextureHeight();
            layer.addChild(_demoLabel);

            // CREATE INSTRUCTIONS LABEL
			var white_ccColor3B:ccColor3B = new ccColor3B();
			white_ccColor3B.r = 0;
			white_ccColor3B.g = 0;
			white_ccColor3B.b = 0;
         	//
            _demoInstructions_cctextfieldttf = CCTextFieldTTF.textFieldWithPlaceHolder("[]", "./assets/fonts/Curse-hd.fnt", 18);
        	_demoInstructions_cctextfieldttf.setColor( white_ccColor3B );
  			//
         	_demoInstructions_cctextfieldttf.setHorizontalAlignment( CCTextAlignment.kCCTextAlignmentLeft );
         	_demoInstructions_cctextfieldttf.setVerticalAlignment( CCVerticalTextAlignment.kCCVerticalTextAlignmentCenter );
          	//
          	_demoInstructions_cctextfieldttf.x = width/2;
            _demoInstructions_cctextfieldttf.y = height - 10;
            layer.addChild(_demoInstructions_cctextfieldttf);

        }

        // --------------------------------------
        // Event Handlers
        // --------------------------------------
       

    }
}