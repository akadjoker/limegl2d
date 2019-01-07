package com.engine.render;

import lime.graphics.Image;
import lime.graphics.opengl.GLTexture;
import lime.graphics.WebGLRenderContext;
import com.engine.misc.Util;


import lime.utils.Assets;


	#if neko

import sys.io.File;
import sys.io.FileOutput;
		#end
		

/**
 * ...
 * @author djoker
 */
class Texture
{
	private var gl:WebGLRenderContext;
    public var data:GLTexture;
	public var width:Int;	
	public var height:Int;
	public var texHeight:Int;
	public var texWidth:Int;
	public var name:String;
	private var exists:Bool;
	public var invTexWidth:Float;
	public var invTexHeight:Float;
	private var image:Image;
	
	
	public function Bind()
	{
	 if (!exists) return;
     gl.bindTexture(gl.TEXTURE_2D, data);
	}


	public function load(url:String, ?flip:Bool = false ) 
	{
	name = url;
	
	 gl = Game.gl;
    image = Assets.getImage(url);
	if (image==null) return ;
	
	if (flip)
	{
	//bitmapData = Util.flipBitmapData(bitmapData);
	}
    data = gl.createTexture ();	
	gl.bindTexture(gl.TEXTURE_2D, data);
	
		
		this.width = image.width;
		this.height = image.height;

		this.texWidth =  Util.getNextPowerOfTwo(width);
		this.texHeight = Util.getNextPowerOfTwo(height);
	
		
		 var isPot = (image.width == texWidth && image.height == texHeight);
		  

			
	gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT);
    gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
	gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);

			if (!isPot)
			{
				
			#if debug
			trace("rescale : " + texWidth + "," + texHeight);
			#end
			} 
			
		#if js
		gl.texImage2D (gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image.src);
		#else
		gl.texImage2D (gl.TEXTURE_2D, 0, gl.RGBA, image.buffer.width, image.buffer.height, 0, gl.RGBA, gl.UNSIGNED_BYTE, image.data);
		#end
		gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
		gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);

    		
            gl.bindTexture(gl.TEXTURE_2D, null);

		     invTexWidth  = 1.0 / texWidth;
             invTexHeight = 1.0 /texHeight;

       
			exists = true;
	
		
	}
	public function new() 
	{
		this.width =0;
		this.height = 0;
		this.texWidth = 0;
		this.texHeight = 0;
		exists = false;
	}
	
	public function dispose()
	{
		gl.deleteTexture(data);
	}
	
	
}