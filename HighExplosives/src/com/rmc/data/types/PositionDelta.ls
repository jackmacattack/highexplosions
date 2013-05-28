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
	import com.rmc.utilities.ToString;
	import com.rmc.utilities.Trigonometry;

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
	public class PositionDelta
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		* Describe this member.
		*
		*/
		private var _fromPoint_ccpoint:CCPoint; 
		public function get fromPoint ()                 	: CCPoint { return _fromPoint_ccpoint;}

		/**
		* Describe this member.
		*
		*/
		private var _toPoint_ccpoint:CCPoint; 
		public function get toPoint ()                 	: CCPoint { return _toPoint_ccpoint;}

		/**
		* Describe this member.
		*
		*/
		private var _deltaPoint_ccpoint:CCPoint; 
		public function get deltaPoint ()                 	: CCPoint { return _deltaPoint_ccpoint;}
		
		/**
		* Describe this member.
		*
		*/
		public function get deltaPointDistance ()                 	: Number { return Trigonometry.DistanceBetween2Points(fromPoint, toPoint);}
		
		/**
		* Describe this member.
		*
		*/
		public function get deltaPointAngle ()                 	: Number { return Trigonometry.AngleBetween2Points(fromPoint, toPoint);}
			
		
		
		// PUBLIC CONST
		
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
		public function PositionDelta(	aFromPoint_ccpoint : CCPoint, 
										aToPoint_ccpoint : CCPoint)
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			_fromPoint_ccpoint 	= aFromPoint_ccpoint;
			_toPoint_ccpoint	= aToPoint_ccpoint;
			_deltaPoint_ccpoint = new CCPoint (aToPoint_ccpoint.x - aFromPoint_ccpoint.x, aToPoint_ccpoint.y - aFromPoint_ccpoint.y)
			
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

			return "[" + getType().getName() + ", fromPoint: " + ToString.CCPointToString(fromPoint) + ", toPoint: " + ToString.CCPointToString(toPoint) + ", deltaPoint: " + ToString.CCPointToString (deltaPoint) + "]";
		}
		
		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------

		
		
	}
}

