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
package com.rmc.managers
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import System.Platform.Platform;

	import cocos2d.CCScaledLayer;
	import cocos2d.CCPoint;
	import com.rmc.data.types.GestureDelegateData;
	import com.rmc.data.types.PositionDelta;
	import com.rmc.utilities.Trigonometry;
	import com.rmc.data.types.Touch;
	import com.rmc.data.types.GestureManagerOptions;

	// --------------------------------------
	// Package Properties
	// --------------------------------------
	
	public delegate onGestureDelegate(aGestureDelegateData:GestureDelegateData):void;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class is...</p>
	 * 
	 */
	public class GestureManager
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/*
		* Describe this member
		* 
		*
		*/
		private var _ccScaledLayer:CCScaledLayer; 
		public function get ccScaledLayer ()                 : CCScaledLayer { return _ccScaledLayer;}
		
		/*
		* Describe this member
		* 
		*
		*/
		private var _gestureManagerOptions:GestureManagerOptions; 
		public function get gestureManagerOptions ()                 : GestureManagerOptions { return _gestureManagerOptions;}

		
		/**
		* Describe this member.
		* 
		*/
		public var onGesture : onGestureDelegate;
		
		/**
		* Describe this member.
		* 
		*/
		public var onGestureDoubleTap : onGestureDelegate;

		/**
		* Describe this member.
		* 
		*/
		public var onGestureSwipe : onGestureDelegate;

		/**
		* Describe this member.
		* 
		*/
		public var onGestureSwipeUp : onGestureDelegate;


		/**
		* Describe this member.
		* 
		*/
		public var onGestureSwipeDown : onGestureDelegate;

		/**
		* Describe this member.
		* 
		*/
		public var onGestureSwipeLeft : onGestureDelegate;

		/**
		* Describe this member.
		* 
		*/
		public var onGestureSwipeRight : onGestureDelegate;

		// PUBLIC CONST
		
		// PRIVATE
		/**
		* Describe this member.
		* 
		*/
		public var _previousTouch : Touch;
		
		/**
		* Describe this member.
		* 
		*/
		public var _touchHistory_dictionary : Dictionary.<int, Touch> = new Dictionary.<int, Touch>()

		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function GestureManager(aCCScaledLayer : CCScaledLayer, aGestureManagerOptions : GestureManagerOptions = null)
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			_ccScaledLayer = aCCScaledLayer;
			if (aGestureManagerOptions != null) {
				_gestureManagerOptions = aGestureManagerOptions;
			} else {
				_gestureManagerOptions = new GestureManagerOptions();	
			}
			
			// METHODS
			init();

			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		* When LoomGameObject.addComponent() is called for this component instance.
		* 
		* @return Boolean
		* 
		*/
		public function init():void
		{

		_ccScaledLayer.onTouchBegan += onTouchBegan;
		_ccScaledLayer.onTouchEnded += onTouchEnded;
		}

		/**
		* When LoomGameObject.removeComponent() is called for this component instance.
		* 
		* @return void
		* 
		*/
		public protected function destroy():void
		{

		_ccScaledLayer.onTouchBegan -= onTouchBegan;
		_ccScaledLayer.onTouchEnded -= onTouchEnded;
		}

		
		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Delegate: <code>onTouchBegan</code>.
		 * 
		 * @param aID_int:int
		 * @param aX_num:Number
		 * @param aY_num:Number
		 *  
		 * @return void
		 * 
		 */
		public function onTouchBegan(aID_int:int, aX_num:Number, aY_num:Number):void
		{
			//Console.print (aID_int + " x: " + aX_num + " y: " + aY_num)
			_touchHistory_dictionary[aID_int] = new Touch(aID_int, new CCPoint (aX_num, aY_num), Platform.getTime()); 
		}
		
		/**
		 * Handles the Delegate: <code>onTouchBegan</code>.
		 * 
		 * @param aID_int:int
		 * @param aX_num:Number
		 * @param aY_num:Number
		 *  
		 * @return void
		 * 
		 */
		public function onTouchEnded(aID_int:int, aX_num:Number, aY_num:Number):void
		{
			//Console.print (aID_int + " x: " + aX_num + " y: " + aY_num)

			var currentTouch			: Touch   = _touchHistory_dictionary[aID_int]

			//
			var gestureFrom_ccpoint 	: CCPoint = currentTouch.positionPoint;
			var gestureTo_ccpoint	 	: CCPoint = new CCPoint (aX_num, aY_num);	
			var gesturePositionDelta 	: PositionDelta = new PositionDelta (gestureFrom_ccpoint, gestureTo_ccpoint);
			
			//
			//Console.print ("gesturePositionDelta " + gesturePositionDelta.x + "," + gesturePositionDelta.y)

			//SEND: GENERIC GESTURE (for now its the same as a swipe really)
			var gestureDelegateData : GestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE, gesturePositionDelta);
			onGesture(gestureDelegateData);

			var swipeDistance_num 		: Number = Trigonometry.DistanceBetween2Points (gestureFrom_ccpoint, gestureTo_ccpoint)
			//Console.print ("swipeDistance_num: " + swipeDistance_num)

			//1. TOUCH, NOT SWIPE
			if (swipeDistance_num < gestureManagerOptions.minimumSwipeDistance) {

				//WAS IT A DOUBLE TAP?
				//TODO, THIS DOES NOT YET CHECK IF THE LAST WAS A "TAP" NECESSARILY
				if (_previousTouch && (currentTouch.time - _previousTouch.time < gestureManagerOptions.doubleClickTimeMS)  ) {
					
					//Console.print ("yessssssssss")
					
					//SEND: GENERIC GESTURE (for now its the same as a swipe really)
					var doubleTapGestureDelegateData : GestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_DOUBLE_TAP, gesturePositionDelta);
					onGestureDoubleTap(doubleTapGestureDelegateData);
				}


			//2. SWIPE, NOT TOUCH
			} else {


				//SEND: SWIPE GESTURE
				var swipeGestureDelegateData : GestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_SWIPE, gesturePositionDelta);
				onGestureSwipe(swipeGestureDelegateData);


				//SEND: SWIPE DIRECTIONAL GESTURE
				//	so find which of 4 directions was it most like
				var swipeAngleRadians_num 	: Number = Trigonometry.AngleBetween2Points(gestureFrom_ccpoint, gestureTo_ccpoint)
				//Console.print ("swipeAngleRadians_num: " + swipeAngleRadians_num)
				//Console.print ("Math.PI 3/4: " + Math.PI*(3/4))
				//Console.print ("welll??? : " + swipeAngleRadians_num  + " > " +  -Math.PI/4)

				var swipeDirectionalGestureDelegateData : GestureDelegateData

				if (swipeAngleRadians_num 			> -Math.PI/4 && 	swipeAngleRadians_num <= Math.PI/4) {
					
					swipeDirectionalGestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_SWIPE_RIGHT, gesturePositionDelta);
					onGestureSwipeRight(swipeDirectionalGestureDelegateData);

				} else if (swipeAngleRadians_num 	> Math.PI/4 && 		swipeAngleRadians_num <= Math.PI*(3/4)) {
					
					swipeDirectionalGestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_SWIPE_UP, gesturePositionDelta);
					onGestureSwipeUp(swipeDirectionalGestureDelegateData);


				} else if (swipeAngleRadians_num 	> -Math.PI*(3/4) && 		swipeAngleRadians_num <= -Math.PI/4) {
					
					swipeDirectionalGestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_SWIPE_DOWN, gesturePositionDelta);
					onGestureSwipeDown(swipeDirectionalGestureDelegateData);
				
				} else if (swipeAngleRadians_num 	> Math.PI*(3/4) || 		swipeAngleRadians_num <= -Math.PI*(3/4)) {
					
					//THIS 'IF' IS AN 'OR' BECAUSE OF POS/NEG #'S
					swipeDirectionalGestureDelegateData = new GestureDelegateData (this, GestureDelegateData.GESTURE_SWIPE_LEFT, gesturePositionDelta);
					onGestureSwipeLeft(swipeDirectionalGestureDelegateData);

				} else  {
					
					//THIS SHOULD NOT OCCUR, EVER.
					Console.print ("GestureManagerError of Angle!!!!!")
					Console.print ("GestureManagerError of Angle!!!!!")
					Console.print ("GestureManagerError of Angle!!!!!")
					Console.print ("GestureManagerError of Angle!!!!!")

				}




			}

			//STORE FOR DOUBLE-TAPS
			_previousTouch   = currentTouch;
		
		}
		

	}
}

