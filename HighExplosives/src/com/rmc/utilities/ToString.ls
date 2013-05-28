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
package com.rmc.utilities
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
	public class ToString
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS

		// PUBLIC CONST
		
		// PRIVATE


		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function ToString()
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES

			// METHODS

			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC


		// PUBLIC STATIC
		/**
		 * Describe this member.
		 * 
		 * @param aCCPoint: CCPoint
		 * 
		 * @return Number
		 * 
		 */
		public static function CCPointToString(aCCPoint: CCPoint) : String 
		{
			return "[" + aCCPoint.getType().getName() + ", x: " + aCCPoint.x+ ", y: " + aCCPoint.y + "]";

		}

		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		


	}
}

