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
class SpriteInvertShader extends Shader
{

 
private var grayUniform:Dynamic;
private var _invert:Float;

	
public function new() 
{
	super();
	_invert = 1;
	

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
 "       varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform float invert;
        uniform sampler2D uImage0;

        void main(void) {
           gl_FragColor = texture2D(uImage0, vTexCoord);
           gl_FragColor.rgb = mix( (vec3(1)-gl_FragColor.rgb) * gl_FragColor.a, gl_FragColor.rgb, 1.0 - invert);
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
grayUniform= gl.getUniformLocation (shaderProgram, "invert");


 		
	}

	public var invert(get, set):Float;
	private function get_invert():Float { return _invert; }
	private function set_invert(value:Float):Float 
	{
		_invert = value;
		return value;
	}
	
	public override function Enable():Void
	{
	   super.Enable();
	   gl.enableVertexAttribArray (texCoordAttribute);
	   gl.uniform1f (grayUniform, _invert);
	}
	public override function Disable():Void
	{
       gl.disableVertexAttribArray (texCoordAttribute);
	   super.Disable();
	}
	
	
}