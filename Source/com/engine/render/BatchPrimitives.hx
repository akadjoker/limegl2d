package com.engine.render;

import com.engine.components.Camera;
import com.engine.misc.BlendMode;
import com.engine.render.filter.PrimitiveShader;
import com.geom.Matrix;
import com.geom.Point;

import com.engine.Game;

import lime.graphics.Image;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLTexture;
import lime.graphics.WebGLRenderContext;
import lime.math.Matrix4;
import lime.utils.Float32Array;

import lime.utils.Float32Array;




/**
 * ...
 * @author djoker
 */
class BatchPrimitives extends Render
{
	public var colorBuffer:GLBuffer;
	public var colorIndex:Int;
	public var colors:Float32Array;
	public var vertexBuffer:GLBuffer;
	public var vertices:Float32Array;
	
	public var fcolorBuffer:GLBuffer;
	public var fcolorIndex:Int;
	public var fcolors:Float32Array;
	public var fvertexBuffer:GLBuffer;
	public var fvertices:Float32Array;
	
	
    private var capacity:Int;




	private var currentBlendMode:Int;


	private var idxCols:Int;
	private var idxPos:Int;

	
    private var fidxCols:Int;
	private var fidxPos:Int;

   
    public var shader:PrimitiveShader;
  




	
	public function new(capacity:Int) 
	{
     super();
	this.vertexBuffer =  gl.createBuffer();
	this.colorBuffer =  gl.createBuffer();
	this.fvertexBuffer =  gl.createBuffer();
	this.fcolorBuffer =  gl.createBuffer();
	this.capacity = capacity;

    idxPos=0;
	idxCols = 0;


	fidxPos=0;
	fidxCols = 0;

		
		try {

		
	


    vertices = new Float32Array(capacity * 3 *4);
	gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
	gl.bufferData(gl.ARRAY_BUFFER,this.vertices , gl.DYNAMIC_DRAW);
	colors = new Float32Array(capacity * 4 * 4);
	gl.bindBuffer(gl.ARRAY_BUFFER, this.colorBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, this.colors , gl.DYNAMIC_DRAW);
    
	fvertices = new Float32Array(capacity * 3 *4);
	gl.bindBuffer(gl.ARRAY_BUFFER, this.fvertexBuffer);
	gl.bufferData(gl.ARRAY_BUFFER,this.fvertices , gl.DYNAMIC_DRAW);
	fcolors = new Float32Array(capacity * 4 * 4);
	gl.bindBuffer(gl.ARRAY_BUFFER, this.fcolorBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, this.fcolors , gl.DYNAMIC_DRAW);

	currentBlendMode = BlendMode.NORMAL;
	} catch( msg : String ) {
    trace("Error occurred: " + msg);
}

	shader = new PrimitiveShader();
	}
	
	

	
	
public function vertex(x:Float, y:Float, ?z:Float = 0.0)
{
		vertices[idxPos++] = x;
        vertices[idxPos++] = y;
        vertices[idxPos++] = z;
	
}
public function color(r:Float, g:Float,b:Float, ?a:Float =0.0)
	{
	colors[idxCols++] = r;
	colors[idxCols++] = g;
	colors[idxCols++] = b;
	colors[idxCols++] = a;	
	}

public function fvertex(x:Float, y:Float, ?z:Float = 0.0)
{
		fvertices[fidxPos++] = x;
        fvertices[fidxPos++] = y;
        fvertices[fidxPos++] = z;
	
}
public function fcolor(r:Float, g:Float,b:Float, ?a:Float =0.0)
	{
	fcolors[fidxCols++] = r;
	fcolors[fidxCols++] = g;
	fcolors[fidxCols++] = b;
	fcolors[fidxCols++] = a;	
	}


	public function begin()
	{
	 idxPos=0;
	 idxCols = 0;
	 fidxPos=0;
	 fidxCols = 0;
	}
    public function end()
	{
	shader.Enable();
	BlendMode.setBlend(currentBlendMode);

	
	 gl.uniformMatrix4fv(shader.projectionMatrixUniform, false,camera.projMatrix.toArray());
     gl.uniformMatrix4fv(shader.modelViewMatrixUniform, false,camera.viewMatrix.toArray());
   
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.fvertexBuffer);	
     gl.bufferSubData(gl.ARRAY_BUFFER, 0, this.fvertices);
     gl.vertexAttribPointer(shader.vertexAttribute, 3, gl.FLOAT, false, 0, 0);
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.fcolorBuffer);
	 gl.bufferSubData(gl.ARRAY_BUFFER, 0, this.fcolors);
     gl.vertexAttribPointer(shader.colorAttribute, 4, gl.FLOAT, false, 0, 0);
 	 gl.drawArrays( gl.TRIANGLES, 0, Std.int(fidxPos / 3));

	 
	 
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);	
     gl.bufferSubData(gl.ARRAY_BUFFER, 0, this.vertices);
     gl.vertexAttribPointer(shader.vertexAttribute, 3, gl.FLOAT, false, 0, 0);
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.colorBuffer);
	 gl.bufferSubData(gl.ARRAY_BUFFER, 0, this.colors);
     gl.vertexAttribPointer(shader.colorAttribute, 4, gl.FLOAT, false, 0, 0);
	 gl.drawArrays(gl.LINES, 0, Std.int(idxPos / 3));
	
  
	 shader.Disable();
	}


	
	//**********
	public function circle (x:Float, y:Float, radius:Float , segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var angle:Float = 2 * 3.1415926 / segments;
		var cos:Float = Math.cos(angle);
		var sin:Float = Math.sin(angle);
		var cx:Float = radius;
		var cy:Float = 0;
		for ( i  in 0...segments)
		 {
	
				vertex(x + cx, y + cy, 0);color(r, g, b, a);
				var temp = cx;
				cx = cos * cx - sin * cy;
				cy = sin * temp + cos * cy;
				
				vertex(x + cx, y + cy, 0);color(r, g, b, a);
			}
			
			vertex(x + cx, y + cy, 0);color(r, g, b, a);
			
			vertex(x, y, 0);color(r, g, b, a);
			
			vertex(x + cx, y + cy, 0);color(r, g, b, a);
		

		var temp:Float = cx;
		cx = radius;
		cy = 0;
		
		vertex(x + cx, y + cy, 0);color(r, g, b, a);
	}
public function fillcircle (x:Float, y:Float, radius:Float , segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var angle:Float = 2 * 3.1415926 / segments;
		var cos:Float = Math.cos(angle);
		var sin:Float = Math.sin(angle);
		var cx:Float = radius;
		var cy:Float = 0;
		segments--;
		for ( i  in 0...segments)
		 {
				fvertex(x, y, 0);fcolor(r, g, b, a);
				fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
				var temp:Float = cx;
				cx = cos * cx - sin * cy;
				cy = sin * temp + cos * cy;

				fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
				
			}
		
			
	
			fvertex(x, y, 0);fcolor(r, g, b, a);
			fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
		

		var temp:Float = cx;
		cx = radius;
		cy = 0;
		
		fvertex(x + cx, y + cy, 0);fcolor(r, g, b, a);
	}

	public function ellipse ( x:Float, y:Float, width:Float, height:Float, segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var  angle:Float = 2 * 3.1415926/ segments;

		var cx:Float = x + width / 2; 
		var cy:Float = y + height / 2;
		

			for (i in 0... segments)
			{
	
				vertex(cx + (width * 0.5 * Math.cos(i * angle)), cy + (height * 0.5 * Math.sin(i * angle)), 0);
				color(r, g, b, a);

		
				vertex(cx + (width * 0.5 * Math.cos((i + 1) * angle)),cy + (height * 0.5 * Math.sin((i + 1) * angle)), 0);
				color(r, g, b, a);
			}
		
	}
	public function fillellipse ( x:Float, y:Float, width:Float, height:Float, segments:Int,r:Float,g:Float,b:Float,?a:Float=1 ) 
	{
	
		var  angle:Float = 2 * 3.1415926/ segments;

		var cx:Float = x + width / 2; 
		var cy:Float = y + height / 2;
		

			for (i in 0... segments)
			{
	
				fvertex(cx + (width * 0.5 * Math.cos(i * angle)), cy + (height * 0.5 * Math.sin(i * angle)), 0);
				fcolor(r, g, b, a);

		     	fvertex(cx ,cy, 0);
				fcolor(r, g, b, a);
				
				fvertex(cx + (width * 0.5 * Math.cos((i + 1) * angle)),cy + (height * 0.5 * Math.sin((i + 1) * angle)), 0);
				fcolor(r, g, b, a);
			}
		
	}	
public function line(x1:Float,y1:Float,x2:Float,y2:Float,r:Float,g:Float,b:Float,?a:Float=1)
{

vertex(x1, y1);
color(r, g, b, a);
vertex(x2, y2);
color(r, g, b, a);
}

public function rect(x:Float,y:Float,width:Float,height:Float,r:Float,g:Float,b:Float,?a:Float=1)
{
			vertex(x, y, 0);color(r, g, b, a);
			vertex(x + width, y, 0);color(r, g, b, a);
			vertex(x + width, y, 0);color(r, g, b, a);
			vertex(x + width, y + height, 0);color(r, g, b, a);
			vertex(x + width, y + height, 0);color(r, g, b, a);
			vertex(x, y + height, 0);color(r, g, b, a);
			vertex(x, y + height, 0);color(r, g, b, a);
			vertex(x, y, 0);color(r, g, b, a);
}
public function rectangle(x:Float,y:Float,x2:Float,y2:Float,r:Float,g:Float,b:Float,?a:Float=1)
{
	
	line(x, y, x2, y, r, g, b, a);
	line(x, y2, x2, y2, r, g, b, a);
	
	line(x, y, x, y2, r, g, b, a);
	line(x2, y, x2, y2, r, g, b, a);
	
}

public function fillrect(x:Float,y:Float,width:Float,height:Float,r:Float,g:Float,b:Float,?a:Float=1)
{
		
			fvertex(x, y, 0);fcolor(r, g, b, a);
			fvertex(x + width, y, 0);fcolor(r, g, b, a);
			fvertex(x + width, y + height, 0);fcolor(r, g, b, a);
			fvertex(x + width, y + height, 0);fcolor(r, g, b, a);
			fvertex(x, y + height, 0);fcolor(r, g, b, a);
			fvertex(x, y, 0);fcolor(r, g, b, a);
}
 public function dispose():Void 
{
		this.vertices = null;
		this.colors = null;
    	gl.deleteBuffer(vertexBuffer);
		gl.deleteBuffer(colorBuffer);
	
		this.fvertices = null;
		this.fcolors = null;
    	gl.deleteBuffer(fvertexBuffer);
		gl.deleteBuffer(fcolorBuffer);
		
	
}


}