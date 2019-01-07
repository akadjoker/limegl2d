package com.engine.render;
import com.engine.components.Camera;
import lime.graphics.WebGLRenderContext;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLTexture;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Render
{
	private var _camera:Camera;
	private var gl:WebGLRenderContext;
	
	public function new() 
	{
		 gl = Game.gl;
		_camera = null;
	}
	
	public var camera(get, set):Camera;
	
	private function get_camera():Camera 
	{
		return _camera;
	}
	
	private function set_camera(value:Camera):Camera 
	{
		_camera = value;
		return value;
	}
	
}