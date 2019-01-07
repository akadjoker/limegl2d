package com.game.gui;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Uicontrol
{
	
	public var x:Float;
	public var y:Float;
    public var alpha:Float;
	public var type:String;
	public var user_is_interacting: Bool;

	public function new(_x:Float,_y:Float) 
	{
		x = _x;
		y = _y;
		alpha = 1;
		type = "GUI";
		
	}
	
	public  function update(dt:Float)
	{
	
	}
	
	public function debug(canvas:BatchPrimitives):Void
	{
		
	}
	public function render(batch:SpriteBatch):Void
	{
		
	}
	
	public function mouseMove(mousex:Int, mousey:Int) 
	{ 
		
	}
	public function mouseUp(mousex:Int, mousey:Int) 
	{ 
		
	}
	public function mouseDown(mousex:Int, mousey:Int) 
	{
		
	}
	
	public function resize(w:Int, h:Int):Void
	{
		
	}
}