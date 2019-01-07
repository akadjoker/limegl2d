package com.engine.render;

import com.engine.misc.BlendMode;
import com.engine.misc.Polygon;
import com.engine.misc.Util;
import com.engine.render.filter.Shader;

import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;






/**
 * ...
 * @author djoker
 */
class BatchRender extends Render
{
	private var u:Float;
    private var v:Float;
	private var u2:Float;
    private var v2:Float;
	private var regionWidth:Int;
	private var regionHeight:Int;
	
	private var colorBuffer:GLBuffer;
	private var vertexBuffer:GLBuffer;
	private var uvBuffer:GLBuffer;
    private var shader:Shader;
	public var Vertex:Array<Float>;
	private var tex:Texture;
	private var points:Array<Float>;
	private var uvs:Array<Float>;
	private var colors:Array<Float>;
	private var dirt:Bool;
	private var _alpha:Float;
	private var _color:Int;
	private var _red:Float;
	private var _green:Float;
	private var _blue:Float;
	private var triangles:Int;
	
	
	public function new(texture:Texture, shaderrender:Shader) 
	{
	super();
	this.shader = shaderrender;	
    this.vertexBuffer =  gl.createBuffer();
	this.colorBuffer  =  gl.createBuffer();
	this.uvBuffer     =  gl.createBuffer();
	
	Vertex = new Array<Float>();
	tex = texture;
	Vertex = new Array<Float>();
	points = new  Array<Float>();
	uvs= new Array<Float>();
	colors = new Array<Float>();
	dirt = true;
	_color = 0xFFFFFF;
    _alpha = _red = _green = _blue = 1;
	triangles = 0;
	setRegion(0, 0, tex.width, tex.height);
	}
	
	private function addTriangle(x:Float, y:Float):Void
	{
		Vertex.push(x);
		Vertex.push(y);
		Vertex.push(0.5);
		

		
		colors.push(_red); colors.push(_green); colors.push(_blue); colors.push(_alpha);
		
		var fact:Float=1;
        var scalex:Float = 1.0 / tex.width  * fact;
		var scaley:Float = 1.0 / tex.height * fact;
		
		
		
		
		var uvWidth:Float  = u2 - u;
		var uvHeight:Float = v2 - v;
		var width:Int  =  regionWidth;
		var height:Int =  regionHeight;
		
	    
		
        var xu:Float =  u + uvWidth * (x / width);
        var xv:Float =  v + uvHeight * ( y / height);
		
		
		uvs.push(xu); 
		uvs.push(xv);
		
		
		
		
		
	}
	
	public function numPoints():Int
	{
		return Std.int(points.length/2);
	}
	public function pointX(index:Int):Float
	{
		if ( index < 0 || index > numPoints()) return 0;
		
		return points[ (index * 2)+0];
	}
	public function pointY(index:Int):Float
	{
		if ( index < 0 || index > numPoints()) return 0;
		
		return points[ (index * 2)+1];
	}
	
 public function scaleVertex(  factorX:Float, factorY:Float):Void
 {
	 var no_verts:Int = Std.int(Vertex.length/3);
	for (v in 0...no_verts)
	{
	  Vertex[v * 3]       *=  factorX;
	  Vertex[(v * 3) + 1] *=  factorY;
	  Vertex[(v * 3) + 2] *=  0;
    }
	dirt = true;
  }
 public function scaleTexCoords(  factorX:Float, factorY:Float):Void
 {
	var no_verts:Int =Std.int( uvs.length / 2 ) ;
	for (v in 0...no_verts)
	{
	  uvs[v * 2]       *=  factorX;
	  uvs[(v * 2) + 1] *=  factorY;
	}
	dirt = true;
  }

  
    public function addVertex(x:Float, y:Float):Void
	{
		points.push(x);
		points.push(y);
	}
	
	public function Clear():Void
	{
   // Vertex = new Array<Float>();
	points = new  Array<Float>();
	//uvs= new Array<Float>();
	//colors = new Array<Float>();
	//triangles = 0;
	}
	
	public function Build():Void
	{
		
	Vertex = new Array<Float>();
	uvs= new Array<Float>();
	colors = new Array<Float>();
	triangles = 0;
	
	
		
 var mTris:Array<UInt> = new Array<UInt>();
 var vp:Polygon = new Polygon(points);
 mTris = vp.triangulate(mTris);
 triangles = 0;
 for (i in 0... Std.int(mTris.length/3))
 {
	var i1:Int = mTris[i * 3 + 0];
	var i2:Int = mTris[i * 3 + 1];
	var i3:Int = mTris[i * 3 + 2];
	addTriangle(pointX(i1), pointY(i1));
	addTriangle(pointX(i2), pointY(i2));
	addTriangle(pointX(i3), pointY(i3));
	triangles++;
} 
	dirt = true;
	
	

	}
	

	

	public function render(currentBlendMode:Int)
	{
		
		if (Vertex.length <= 0) return;
		if (triangles <= 0) return;
		
		if (dirt)
		{
	gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(Vertex) , gl.STATIC_DRAW);
	gl.bindBuffer(gl.ARRAY_BUFFER, null);
	
	gl.bindBuffer(gl.ARRAY_BUFFER, this.colorBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(colors) , gl.STATIC_DRAW);
	gl.bindBuffer(gl.ARRAY_BUFFER, null);
	
	gl.bindBuffer(gl.ARRAY_BUFFER, this.uvBuffer);
 	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(uvs) , gl.STATIC_DRAW);
	gl.bindBuffer(gl.ARRAY_BUFFER, null);
	dirt = false;
	
	return;
		}

	
	 shader.Enable();	
	 BlendMode.setBlend(currentBlendMode);
	 shader.setTexture(tex);

	
	 gl.uniformMatrix4fv(shader.projectionMatrixUniform, false,camera.projMatrix.toArray());
     gl.uniformMatrix4fv(shader.modelViewMatrixUniform, false,camera.viewMatrix.toArray());
   
	 

	 gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);	
     gl.vertexAttribPointer(shader.vertexAttribute, 3, gl.FLOAT, false, 0, 0);
	 
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.uvBuffer);
     gl.vertexAttribPointer(shader.texCoordAttribute, 2, gl.FLOAT, false, 0, 0);
	 
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.colorBuffer);
     gl.vertexAttribPointer(shader.colorAttribute, 4, gl.FLOAT, false, 0, 0);
	 
	 gl.drawArrays(gl.TRIANGLES, 0, triangles *3  );
	
	 
	 
      shader.Disable();
	}
	

	
    public var alpha(get, set):Float;
	private function get_alpha():Float { return _alpha; }
	private function set_alpha(value:Float):Float
	{
		value = value < 0 ? 0 : (value > 1 ? 1 : value);
		if (_alpha == value) return value;
		_alpha = value;
		return _alpha;
	}	
	public var color(get, set):Int;
	private function get_color():Int { return _color; }
	private function set_color(value:Int):Int
	{
		value &= 0xFFFFFF;
		if (_color == value) return value;
		_color = value;
		_red = Util.getRed(_color) / 255;
		_green = Util.getGreen(_color) / 255;
		_blue = Util.getBlue(_color) / 255;
		return _color;
	}

	public function setUv(u:Float, v:Float, u2:Float, v2:Float): Void
	{
		var texWidth:Int = tex.width;
		var texHeight:Int = tex.height;
		
		
		regionWidth = Math.round(Math.abs(u2 - u) * texWidth);
		regionHeight = Math.round(Math.abs(v2 - v) * texHeight);

		// For a 1x1 region, adjust UVs toward pixel center to avoid filtering artifacts on AMD GPUs when drawing very stretched.
		if (regionWidth == 1 && regionHeight == 1) 
		{
			var adjustX:Float = 0.25 / texWidth;
			u += adjustX;
			u2 -= adjustX;
			var adjustY:Float = 0.25 / texHeight;
			v += adjustY;
			v2 -= adjustY;
		}

		this.u = u;
		this.v = v;
		this.u2 = u2;
		this.v2 = v2;
		dirt = true;
	}
	
	public function setRegion(x:Int, y:Int, widht:Int, height:Int): Void
	{
		var invTexWidth:Float  = 1 / tex.width;
		var invTexHeight:Float = 1 / tex.height;
		setUv(x * invTexWidth, y * invTexHeight, (x + widht) * invTexWidth, (y + height) * invTexHeight);
		regionWidth = Std.int(Math.abs(widht));
		regionHeight =Std.int( Math.abs(height));
	}
	public function flipUV ( x:Bool,  y:Bool) :Void
	{
		if (x) {
			var temp = u;
			u = u2;
			u2 = temp;
		}
		if (y) {
			var temp = v;
			v = v2;
			v2 = temp;
		}
		dirt = true;
	}
	public function scrollUV (xAmount:Float,  yAmount:Float):Void 
	{
		if (xAmount != 0) {
			var width:Float = (u2 - u) * tex.width;
			u = (u + xAmount) % 1;
			u2 = u + width / tex.width;
		}
		if (yAmount != 0) {
			var height:Float = (v2 - v) * tex.height;
			v = (v + yAmount) % 1;
			v2 = v + height / tex.height;
		}
		
	
		
		dirt = true;
	}

	
}