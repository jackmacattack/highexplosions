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
	public class Touch
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		* Describe this member.
		*
		*/
		private var _id_int:int; 
		public function get id ()                 	: int { return _id_int;}
	 
		/**
		* Describe this member.
		*
		*/
		private var _positionPoint_ccpoint:CCPoint; 
		public function get positionPoint ()                 	: CCPoint { return _positionPoint_ccpoint;}

		/**
		* Describe this member.
		*
		*/
		private var _time_num:Number; 
		public function get time ()                 	: Number { return _time_num;}


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
		public function Touch(aID_int : int, aPositionPoint_ccpoint : CCPoint, aTime_num : Number)
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			_id_int 				= aID_int;
			_positionPoint_ccpoint 	= aPositionPoint_ccpoint;
			_time_num				= aTime_num;
			
			
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
		public function toString() : String
		{
			return "[" + getType().getName() + " id: " + id+ ", positionPoint: " + positionPoint + ", time: " + time + "]";
		}
		
		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------

		
		
	}
}

