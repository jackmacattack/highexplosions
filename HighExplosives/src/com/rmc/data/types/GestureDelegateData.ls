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
package com.rmc.data.types
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import cocos2d.CCPoint;
	import com.rmc.data.types.PositionDelta;

	// --------------------------------------
	// Package Properties
	// --------------------------------------
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class is...</p>
	 * 
	 */
	public class GestureDelegateData extends DelegateData
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		* Describe this member.
		*
		*/
		private var _positionDelta:PositionDelta; 
		public function get positionDelta ()                 	: PositionDelta { return _positionDelta;}


		// PUBLIC CONST
		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE : String = "GESTURE";
		

		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_DOUBLE_TAP : String = "GESTURE_DOUBLE_TAP";
		




		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_SWIPE : String = "GESTURE_SWIPE";

		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_SWIPE_UP : String = "GESTURE_SWIPE_UP";

		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_SWIPE_DOWN : String = "GESTURE_SWIPE_DOWN";

		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_SWIPE_LEFT : String = "GESTURE_SWIPE_LEFT";

		/**
		* Describe this member.
		* 
		*/
		public static const GESTURE_SWIPE_RIGHT : String = "GESTURE_SWIPE_RIGHT";

		// PRIVATE
		/**
		* Describe this member.
		* 
		*/

		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function GestureDelegateData(	aTarget_object : Object, aType_str : String, 
												aPositionDelta : PositionDelta)
		{
			// SUPER
			super(aTarget_object, aType_str);
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			_positionDelta = aPositionDelta
			
			// METHODS

			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * Describe this member.
		 * 
		 * @return String Describe this return.
		 * 
		 */
		override public function toString() : String
		{

			return "[" + getType().getName() + " target: " + target.getType().getName() + ", type: " + type + ", positionDelta: " + _positionDelta.toString() + "]";
		}
		
		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------

		
		
	}
}

