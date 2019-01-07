package com.engine.render;

import com.engine.misc.BlendMode;
import com.engine.render.filter.Shader;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLTexture;
import lime.graphics.WebGLRenderContext;


import lime.utils.Float32Array;


/**
 * ...
 * @author djoker
 */
class ArrayBuffer extends Render
{
	public var coordBuffer:GLBuffer;
	public var tex0Buffer:GLBuffer;
	public var colBuffer:GLBuffer;

	
	
	public var pipeline:Shader;
	
	public function new(shader:Shader) 
	{
		gl=Game.
		this.pipeline = shader;
		
		
		coordBuffer = GL.createBuffer();
		tex0Buffer = GL.createBuffer();
		colBuffer  = GL.createBuffer();
		
		
		
	}
	   
	public function uploadVertex(v:Array<Float>):Void
    {
		   
		    GL.bindBuffer(GL.ARRAY_BUFFER, coordBuffer);
	        GL.bufferData(GL.ARRAY_BUFFER,  new Float32Array( v), GL.STATIC_DRAW);
			GL.bindBuffer(GL.ARRAY_BUFFER, null);
    }
	public function uploadVertexData(v:Float32Array):Void
    {
		   
		    GL.bindBuffer(GL.ARRAY_BUFFER, coordBuffer);
	        GL.bufferData(GL.ARRAY_BUFFER, v, GL.STATIC_DRAW);
			GL.bindBuffer(GL.ARRAY_BUFFER, null);
    }
	

	public function uploadColors(v:Array<Float>):Void
    {
		   
		   if (!useColors) return;
		    GL.bindBuffer(GL.ARRAY_BUFFER, colBuffer);
	        GL.bufferData(GL.ARRAY_BUFFER,  new Float32Array( v), GL.STATIC_DRAW);
			GL.bindBuffer(GL.ARRAY_BUFFER, null);
    }

	public function uploadUVCoord(v:Array<Float>):Void
    {
		   if (!useTexture) return;
		    GL.bindBuffer(GL.ARRAY_BUFFER, tex0Buffer);
	        GL.bufferData(GL.ARRAY_BUFFER,  new Float32Array( v), GL.STATIC_DRAW);
			GL.bindBuffer(GL.ARRAY_BUFFER, null);
    }
	
	
	public function setUVCoord(v:Float32Array):Void
    {
		   
		   if (!useTexture) return;
		    GL.bindBuffer(GL.ARRAY_BUFFER, tex0Buffer);
	        GL.bufferData(GL.ARRAY_BUFFER, v , GL.STATIC_DRAW);
	 }
			public function setColors(v:Float32Array):Void
    {
		   
		   if (!useColors) return;
		    GL.bindBuffer(GL.ARRAY_BUFFER, colBuffer);
	        GL.bufferData(GL.ARRAY_BUFFER,  v, GL.STATIC_DRAW);
	 }
		public function setVertex(v:Float32Array):Void
    {
		   
		    GL.bindBuffer(GL.ARRAY_BUFFER, coordBuffer);
	        GL.bufferData(GL.ARRAY_BUFFER,  v, GL.STATIC_DRAW);
	  }	 
	  
	public function render(primitiveType:Int,Num_Triangles:Int):Void
	{
		
	    GL.bindBuffer(GL.ARRAY_BUFFER, coordBuffer);
		GL.vertexAttribPointer(pipeline.vertexAttribute, 3, GL.FLOAT, false, 0, 0); 
    	GL.enableVertexAttribArray (pipeline.vertexAttribute);
	
	         GL.bindBuffer(GL.ARRAY_BUFFER, tex0Buffer);
   	         GL.vertexAttribPointer(pipeline.texCoord0Attribute, 2, GL.FLOAT, false, 0, 0);  
		     GL.enableVertexAttribArray (pipeline.texCoord0Attribute);
			
		
	         GL.bindBuffer(GL.ARRAY_BUFFER, colBuffer);
   	         GL.vertexAttribPointer(pipeline.colorAttribute, 4, GL.FLOAT, false, 0, 0);  
	         GL.enableVertexAttribArray (pipeline.colorAttribute);
		
	    
		
        GL.drawArrays(primitiveType, 0, Num_Triangles);
	}
}