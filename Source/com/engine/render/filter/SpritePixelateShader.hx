package com.engine.render.filter;

import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;
import com.geom.Matrix;
import com.geom.Point;
import com.engine.Game;

/**
 * ...
 * @author djoker
 */
class SpritePixelateShader extends Shader
{

    private var pixelSizeX:Float = 10.9;
    private var pixelSizeY:Float = 10.9;
    private var pixelSizeUniform:Dynamic;

	
public function new() 
{
	super();
	


 var textureVertexShader=
"
attribute vec3 aVertexPosition;
attribute vec2 aTexCoord;
attribute vec4 aColor;

varying vec2 vTexCoord;
varying vec4 vColor;

uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
void main(void) 
{
vTexCoord = aTexCoord;
vColor = aColor;
gl_Position = uProjectionMatrix * uModelViewMatrix *  vec4 (aVertexPosition, 1.0);

}";


	
 var textureFragmentShader = 
 #if !desktop
"precision mediump float;" +
#end
  " 
        varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform vec2 pixelSize;
        uniform sampler2D uImage0;

        void main(void) 
		{
           vec4 dimensions = vec4(10000, 100, 10, 10);
		   vec2 size = dimensions.xy/pixelSize;
           vec2 color = floor( ( vTexCoord * size ) ) / size + pixelSize/dimensions.xy * 0.5;
           gl_FragColor = texture2D(uImage0, color);
       }";

var vertexShader = gl.createShader (gl.VERTEX_SHADER);
gl.shaderSource (vertexShader, textureVertexShader);
gl.compileShader (vertexShader);
if (gl.getShaderParameter (vertexShader, gl.COMPILE_STATUS) == 0) 
{
throw (gl.getShaderInfoLog(vertexShader));
}

var fragmentShader = gl.createShader (gl.FRAGMENT_SHADER);
gl.shaderSource (fragmentShader, textureFragmentShader);
gl.compileShader (fragmentShader);

if (gl.getShaderParameter (fragmentShader, gl.COMPILE_STATUS) == 0) {

 throw(gl.getShaderInfoLog(fragmentShader));

}

shaderProgram = gl.createProgram ();
gl.attachShader (shaderProgram, vertexShader);
gl.attachShader (shaderProgram, fragmentShader);
gl.linkProgram (shaderProgram);

if (gl.getProgramParameter (shaderProgram, gl.LINK_STATUS) == 0) 
{
throw "Unable to initialize the shader program.";
}

vertexAttribute = gl.getAttribLocation (shaderProgram, "aVertexPosition");
texCoordAttribute = gl.getAttribLocation (shaderProgram, "aTexCoord");
colorAttribute = gl.getAttribLocation (shaderProgram, "aColor");
projectionMatrixUniform = gl.getUniformLocation (shaderProgram, "uProjectionMatrix");
modelViewMatrixUniform = gl.getUniformLocation (shaderProgram, "uModelViewMatrix");
imageUniform = gl.getUniformLocation (shaderProgram, "uImage0");
pixelSizeUniform = gl.getUniformLocation (shaderProgram, "pixelSize");


 		
	}


	
	public override function Enable():Void
	{
	   super.Enable();
	   gl.enableVertexAttribArray (texCoordAttribute);
	   gl.uniform2f (pixelSizeUniform, pixelSizeX, pixelSizeY);
	}
	public function setPixelSize(x:Float,y:Float)
	{
	pixelSizeX = x;	
	pixelSizeY = y;
	}
	public override function Disable():Void
	{
       gl.disableVertexAttribArray (texCoordAttribute);
	   super.Disable();
	}
	
	
}