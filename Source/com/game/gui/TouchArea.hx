package com.game.gui;
import com.engine.Game;
import com.engine.misc.Util;
import com.engine.render.BatchPrimitives;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class TouchArea extends Uicontrol
{

	public var touch:Bool;
	public var width     : Int;
	public var height     : Int;
 
	private var _grabbed:Bool;

	
	public function new(x:Float,y:Float,width:Int,height:Int) 
	{
		super(x, y);
		type = "TouchArea";
		this.width      = width;
		this.height     = height;
        alpha = 0.2;
		touch = false;
		reset();
		
	}
	public function reset() 
	{
	user_is_interacting = false;
	}
	private function updateDirection(mouse_x: Int, mouse_y: Int)
	{
		touch = false;

		if (user_is_interacting)
		{
						touch = true;
				
		
		}
	}
	public override function mouseMove(mouse_x: Int, mouse_y: Int)
	{
		updateDirection(mouse_x, mouse_y);
	}
	
	public override function mouseDown(mouse_x: Int, mouse_y: Int) 
	{
		if (checkMouseCollision(mouse_x, mouse_y)) 
		{
			user_is_interacting = true;
			_grabbed = true;
			updateDirection(mouse_x, mouse_y);
		}
	}
	
	public override function mouseUp(mouse_x: Int, mouse_y: Int) 
	{
		touch = false;
		user_is_interacting = false;
		_grabbed = false;
	}
	

	public function checkMouseCollision(mouse_x: Int, mouse_y: Int): Bool {
		if ((mouse_x >= x) && (mouse_y >= y) && (mouse_x < x + width) && (mouse_y < y + height)) return true;
		return false;
	}
	


		
	
    public override function update(dt:Float)
	{
		
	}
	override public function debug(canvas:BatchPrimitives):Void
	{
		
		var a :Float= 0; 
		
		if (user_is_interacting)
		{
			a = 0.7;
		} else
		{
			a = 0.2;
			
		}
        alpha = Util.Lerp(alpha, a, 5 *  Game.game.deltaTime);

			
	    canvas.fillrect(x, y, width, height,0,1,1,alpha);
	  
		
	}
		
}