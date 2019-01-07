package com.engine.misc;


import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;

import lime.graphics.opengl.GLProgram;

/**
 * ...
 * @author djoker
 */
class BlendMode
{

	public static inline var NORMAL:Int      = 0;
	public static inline  var ADD:Int         = 1;
	public static inline  var MULTIPLY:Int    = 2;
	public static inline  var SCREEN:Int      = 3;
	public static inline  var TRANSPARENT:Int      = 4;



static 	public function setBlend(mode:Int ) 
	{
		
	 switch( mode ) {
    case BlendMode.NORMAL:
       Game.gl.blendFunc(Game.gl.SRC_ALPHA,Game.gl.ONE_MINUS_SRC_ALPHA );
	  
    case BlendMode.ADD:
        Game.gl.blendFunc(Game.gl.SRC_ALPHA, Game.gl.DST_ALPHA );
    case BlendMode.MULTIPLY:
        Game.gl.blendFunc(Game.gl.DST_COLOR,Game.gl.ONE_MINUS_SRC_ALPHA );
    case BlendMode.SCREEN:
       Game.gl.blendFunc(Game.gl.SRC_ALPHA, Game.gl.ONE );	
	case BlendMode.TRANSPARENT:   
		Game.gl.blendFunc(Game.gl.ONE, Game.gl.ONE_MINUS_SRC_ALPHA );	
    default:
        Game.gl.blendFunc(Game.gl.ONE, Game.gl.ONE_MINUS_SRC_ALPHA );
		
		
    }
	
	
}
	
	
	
	
		
	
}