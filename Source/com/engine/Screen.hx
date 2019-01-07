package com.engine;
import com.engine.components.GameObject;
import com.game.gui.Uicontrol;
import com.engine.render.Texture;


/**
 * ...
 * @author djoker
 */
class Screen extends GameObject
{
	public var width:Int;
	public var height:Int;
	


    public var game:Game = null;
	
	public function show() {  }
	public function render() { }
	public function update(dt:Float) { }
	public function resize(width:Int, height:Int) {}
	
	public function mouseMove(mousex:Float, mousey:Float) { };
	public function mouseUp(mousex:Float, mousey:Float) { };
	public function mouseDown(mousex:Float, mousey:Float) { };
	public function keyDown(key:Int) { };
	public function keyUp(key:Int) { };
	
	
	public function getTexture(url:String ):Texture 
{	
	return game.getTexture(url, false);
}
	
}