package com.engine.render.filter;


import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;
import com.geom.Matrix;
import com.geom.Point;

import com.engine.render.filter.Filter;


/**
 * ...
 * @author djoker
 */
class PrimitiveShader extends Shader
{


	
	public function new() 
	{
    super();

	

 var colorVertexShader=
"
attribute vec3 aVertexPosition;
attribute vec4 aColor;

varying vec4 vColor;

uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
void main(void) 
{
vColor = aColor;
gl_Position = uProjectionMatrix * uModelViewMatrix * vec4 (aVertexPosition, 1.0);
}";


 var colorFragmentShader=

#if !desktop
"precision mediump float;" +
#end
"

varying vec4 vColor;
void main(void)
{
	gl_FragColor =  vColor;
}";

		try {

var vertexShader = gl.createShader (gl.VERTEX_SHADER);
gl.shaderSource (vertexShader, colorVertexShader);
gl.compileShader (vertexShader);

if (gl.getShaderParameter (vertexShader, gl.COMPILE_STATUS) == 0) 
{

throw (gl.getShaderInfoLog(vertexShader));

}


var fragmentShader = gl.createShader (gl.FRAGMENT_SHADER);
gl.shaderSource (fragmentShader, colorFragmentShader);
gl.compileShader (fragmentShader);

if (gl.getShaderParameter (fragmentShader, gl.COMPILE_STATUS) == 0) {
 throw(gl.getShaderInfoLog(fragmentShader));

}

shaderProgram = gl.createProgram ();
gl.attachShader (shaderProgram, vertexShader);
gl.attachShader (shaderProgram, fragmentShader);
gl.linkProgram (shaderProgram);

if (gl.getProgramParameter (shaderProgram, gl.LINK_STATUS) == 0) {


throw "Unable to initialize the shader program.";
}

vertexAttribute = gl.getAttribLocation (shaderProgram, "aVertexPosition");
colorAttribute = gl.getAttribLocation (shaderProgram, "aColor");
projectionMatrixUniform = gl.getUniformLocation (shaderProgram, "uProjectionMatrix");
modelViewMatrixUniform = gl.getUniformLocation (shaderProgram, "uModelViewMatrix");

} catch( msg : String ) {
    trace("Error occurred: " + msg);
}

 		
	}


}