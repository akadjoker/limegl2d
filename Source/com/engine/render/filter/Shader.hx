package com.engine.render.filter;
import  lime.graphics.opengl.GL;
import  lime.graphics.opengl.GLBuffer;
import  lime.graphics.opengl.GLProgram;
import lime.graphics.WebGLRenderContext;
import lime.utils.Float32Array;
import com.geom.Matrix3D;
import com.engine.Game;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Shader implements IShader
{
 public var vertexAttribute :Int;
 public var colorAttribute :Int;
 public var imageUniform:Dynamic;
 public var texCoordAttribute:Int;
 private var shaderProgram:GLProgram;
 public var projectionMatrixUniform:Dynamic;
 public var modelViewMatrixUniform:Dynamic;
 public var gl:WebGLRenderContext;
 

	public function new() 
	{
		gl = Game.gl;
		
	}
	public  function Enable():Void
	{
	   gl.useProgram (shaderProgram);
       gl.enableVertexAttribArray (vertexAttribute);
       gl.enableVertexAttribArray (colorAttribute);
	}
	public function Disable():Void
	{
       gl.disableVertexAttribArray (vertexAttribute);
  	   gl.disableVertexAttribArray (colorAttribute);
	   gl.useProgram (null);
	
	}
	public function setTexture(tex:Texture):Void
	{
 	 if (tex!=null) tex.Bind();
     if (imageUniform!=null)gl.uniform1i (imageUniform, 0);
	}

	public function dispose():Void
	{
	gl.deleteProgram(shaderProgram);
	}
}