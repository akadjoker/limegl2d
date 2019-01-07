package com.engine.render;

import com.engine.components.Camera;
import com.engine.Game;
import com.engine.misc.Clip;
import com.engine.misc.BlendMode;
import com.engine.render.filter.Shader;

import com.geom.Matrix;
import com.geom.Point;
import lime.utils.Float32Array;
import lime.utils.Int16Array;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLTexture;


import com.engine.render.filter.Filter;
import com.engine.render.filter.SpriteShader;
/**
 * ...
 * @author djoker
 */
class SpriteAtlas extends Render
{

	private var capacity:Int;
	private var numVerts:Int;
	private var numIndices:Int; 
	private var vertices:Float32Array;
	private var indices:Int16Array;
	private var lastIndexCount:Int;
	private var drawing:Bool;
	private var currentBatchSize:Int;
	private var currentBlendMode:Int;
	private var currentBaseTexture:Texture;
    private var vertexBuffer:GLBuffer;
    private var indexBuffer:GLBuffer;
    private var invTexWidth:Float = 0;
    private var invTexHeight:Float = 0;
	public var vertexStrideSize:Int;
    public var shader:Shader;


	public function new(texture:Texture,capacity:Int,shaderrender:Shader) 
	{
		super();
	   this.shader = shaderrender;
		this.capacity = capacity;
        vertexStrideSize =  (3+2+4) *4; // 9 floats (x, y, z,u,v, r, g, b, a)
 
	   numVerts = capacity * vertexStrideSize;
       numIndices = capacity * 6;
      vertices = new Float32Array(numVerts);

        this.indices = new Int16Array(numIndices); 
		var length = Std.int(this.indices.length/6);
		
		for (i in 0...length) 
		{
			var index2 = i * 6;
			var index3 = i * 4;
			this.indices[index2 + 0] = index3 + 0;
			this.indices[index2 + 1] = index3 + 1;
			this.indices[index2 + 2] = index3 + 2;
			this.indices[index2 + 3] = index3 + 0;
			this.indices[index2 + 4] = index3 + 2;
			this.indices[index2 + 5] = index3 + 3;
		};
		

    drawing = false;
    currentBatchSize = 0;
	currentBlendMode = BlendMode.NORMAL;
    this.currentBaseTexture = texture;
    invTexWidth  = 1.0 / texture.texWidth;
    invTexHeight = 1.0 / texture.texHeight;

	
	 // create a couple of buffers
    vertexBuffer = gl.createBuffer();
    indexBuffer = gl.createBuffer();


    //upload the index data
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, indices, gl.STATIC_DRAW);

    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
	
	indices = null;
	shader = new SpriteShader();

	}
	
  

	
	
inline public function RenderNormal(x:Float, y:Float)
{
	
 var u:Float = 0;
 var v:Float = 1;
 var u2:Float = 1;
 var v2:Float = 0;
 var fx2:Float = x + currentBaseTexture.width;
 var fy2:Float = y + currentBaseTexture.height;





var index:Int = currentBatchSize *  vertexStrideSize;

vertices[index++] = x;
vertices[index++] = y;
vertices[index++] = 0;
vertices[index++] = u;vertices[index++] = v2;
vertices[index++] = 1;vertices[index++] = 1;vertices[index++] = 1;vertices[index++] = 1;
	
vertices[index++] = x;
vertices[index++] = fy2;
vertices[index++] = 0;
vertices[index++] = u;vertices[index++] = v;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;

vertices[index++] = fx2;
vertices[index++] = fy2;
vertices[index++] = 0;
vertices[index++] = u2;vertices[index++] = v;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;

vertices[index++] = fx2;
vertices[index++] = y;
vertices[index++] = 0;
vertices[index++] = u2;vertices[index++] = v2;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;


    currentBatchSize++;

	}
	
	inline public function RenderClip(x:Float, y:Float,clip:Clip)
{
	

				
 var u:Float  = clip.x * invTexWidth;
 var u2:Float = (clip.x + clip.width) * invTexWidth;
 
 var v:Float  = (clip.y + clip.height) * invTexHeight;
 var v2:Float = clip.y * invTexHeight;	
	

 var fx2:Float = x + clip.width;
 var fy2:Float = y + clip.height;





var index:Int = currentBatchSize *  vertexStrideSize;

vertices[index++] = x;
vertices[index++] = y;
vertices[index++] = 0;
vertices[index++] = u;vertices[index++] = v2;
vertices[index++] = 1;vertices[index++] = 1;vertices[index++] = 1;vertices[index++] = 1;
	
vertices[index++] = x;
vertices[index++] = fy2;
vertices[index++] = 0;
vertices[index++] = u;vertices[index++] = v;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;

vertices[index++] = fx2;
vertices[index++] = fy2;
vertices[index++] = 0;
vertices[index++] = u2;vertices[index++] = v;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;

vertices[index++] = fx2;
vertices[index++] = y;
vertices[index++] = 0;
vertices[index++] = u2;vertices[index++] = v2;
vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1; vertices[index++] = 1;


    currentBatchSize++;

	}
	
	public function Begin()
	{
	 currentBatchSize = 0;
	 shader.Enable();
	 gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
     gl.vertexAttribPointer(shader.vertexAttribute, 3, gl.FLOAT, false, vertexStrideSize, 0);
     gl.vertexAttribPointer(shader.texCoordAttribute  , 2, gl.FLOAT, false, vertexStrideSize, 3 * 4);
     gl.vertexAttribPointer(shader.colorAttribute, 4, gl.FLOAT, false, vertexStrideSize, (3+2) * 4);
     
    }
	public function End()
	{
	if (currentBatchSize==0) return;
	shader.setTexture(currentBaseTexture);
	BlendMode.setBlend(currentBlendMode);
	gl.uniformMatrix4fv(shader.projectionMatrixUniform, false,camera.projMatrix.toArray());
    gl.uniformMatrix4fv(shader.modelViewMatrixUniform, false,camera.viewMatrix.toArray());
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.indexBuffer);
    gl.drawElements(gl.TRIANGLES, currentBatchSize * 6, gl.UNSIGNED_SHORT, 0);
    currentBatchSize = 0;
    shader.Disable();
	}
 public function dispose():Void 
{
	    gl.deleteBuffer(indexBuffer);
		gl.deleteBuffer(vertexBuffer);

}



}