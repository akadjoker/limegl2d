package com.game.gui;



import com.engine.Game;
import com.engine.misc.Util;
import com.engine.render.BatchPrimitives;
import com.geom.Point;



class VirtualAnalogStick extends Uicontrol {
	// Direction that the user is pressing:

	public var strength: Float;
	public var angle: Float;
	
	private var _grabbed:Bool;
	private var knob:Point = new Point();
	private var _vx:Float = 0;
	private var _vy:Float = 0;
	private var _spring:Float = 400;
	private var _friction:Float = 0.0005;

	public var size         : Int;
	public var dead_distance: Int; // No reaction inside the dead_distance to the center
	public var full_distance: Int; // Full reaction (strength 1.0) at full_distance to the center
	public var move_distance: Int; // No reaction outside the move_distance to the center
	
	//
	// Constructor
	//
	// x, y     : Position on screen in pixels
	// size     : Size in pixels (used for both width and height)
	// dead_area: Within this area in the center no direction is pressed
	// move_area: Outside of this area no direction is pressed
	//
	public function new(x: Float, y: Float, size: Int, dead_distance: Int,  move_distance: Int) 
	{
	    super(x,y);
		type = "JoyPad";

		
		this.size          = size;
		this.dead_distance = dead_distance;
         full_distance = 1;
		this.move_distance = move_distance;
		
		resetInteraction();
	}
	
	public function reset() 
	{
		resetInteraction();
	}
	

	private function resetInteraction() {
		angle    = 0.0;
		strength = 0.0;
		user_is_interacting = false;
	}
	

	private function updateDirection(mouse_x: Int, mouse_y: Int) 
	{
		angle    = 0.0;
	 	strength = 0.0;
		if (user_is_interacting) {
			// Determine the direction in which the virtual analog stick is hold.
			// No direction inside the "dead-area" or outside the "move-area".
			if ((isMouseWithinMoveDistance(mouse_x, mouse_y)) && (!isMouseWithinDeadDistance(mouse_x, mouse_y))) 
			{
				var mid_x: Float = x + size / 2;
				var mid_y: Float = y + size / 2;
				var dx: Float = mouse_x - mid_x;
				var dy: Float = mouse_y - mid_y;
				knob.x = dx;
				knob.y = dy;
				if (dx == 0.0 && dy == 0.0) { // Angle not defined in the center
					angle    = 0.0;
					strength = 0.0;
				}
				else {
					angle    = Math.atan2(dy, dx);
					strength = (Math.sqrt(dx * dx + dy * dy) - dead_distance) / (full_distance - dead_distance);
					if (strength > 1.0) strength = 1.0;
				}
				
				
			}
		}
	}
	

	
	public override function mouseMove(mouse_x: Int, mouse_y: Int)
	{
		updateDirection(mouse_x, mouse_y);
		_grabbed = true;
	}
	
	public override function mouseDown(mouse_x: Int, mouse_y: Int)
	{
		if (checkMouseCollision(mouse_x, mouse_y))
		{
			_grabbed = true;
			user_is_interacting = true;
			updateDirection(mouse_x, mouse_y);
		}
	}
	
	public override function mouseUp(mouse_x: Int, mouse_y: Int)
	{
		user_is_interacting = false;
		_grabbed = false;
	}
	

	public function checkMouseCollision(mouse_x: Int, mouse_y: Int): Bool 
	{
		if ((mouse_x >= x) && (mouse_y >= y) && (mouse_x < x + size) && (mouse_y < y + size)) return true;
		return false;
	}
	

	
	public function distanceToCenter(mouse_x: Int, mouse_y: Int): Float {
		var mid_x: Float = x + size / 2;
		var mid_y: Float = y + size / 2;
		var dx: Float = mouse_x - mid_x;
		var dy: Float = mouse_y - mid_y;
		var distance: Float = Math.sqrt(dx * dx + dy * dy);
		return distance;
	}
	
	public function isMouseWithinMoveDistance(mouse_x: Int, mouse_y: Int): Bool 
	{
		if (distanceToCenter(mouse_x, mouse_y) <= move_distance) return true;
		return false;
	}
	/*
	public function isMouseWithinFullDistance(mouse_x: Int, mouse_y: Int): Bool {
		if (distanceToCenter(mouse_x, mouse_y) <= full_distance) return true;
		return false;
	}
*/	
	public function isMouseWithinDeadDistance(mouse_x: Int, mouse_y: Int): Bool {
		if (distanceToCenter(mouse_x, mouse_y) <= dead_distance) return true;
		return false;
	}
	
	public override function update(dt:Float)
	{
		/*
		#if android
		
	
		    var id:Int = -1;
		    mouseUp( 0,0);	
			for (touch in game.touches)
		    {
				id = touch.id;
				
				mouseDown(Std.int(touch.x), Std.int(touch.y));
				
				
			  //trace(touch.id + " ," +touch.x + ", " +touch.y);
		    }
		
			
		
		 
		#else
		
		if (mouse_check())
		{
			mouseDown(mouse_x(), mouse_y());
		} else
		if (mouse_check_released())
		{
			mouseUp(mouse_x(), mouse_y());
		}
		
		
		#end
		*/
		
		
		
		
		        if (!_grabbed)
				{
		         	_vx += -knob.x * _spring;
					_vy += -knob.y * _spring;
					knob.x += (_vx *= _friction);
					knob.y += (_vy *= _friction);
				}
				
				trace(angle);
	}
	override public function debug(canvas:BatchPrimitives):Void
	{
		var a :Float= 0; 
		
		if (user_is_interacting)
		{
			a = 1;
		} else
		{
			a = 0.1;
			
		}
	

		alpha = Util.Lerp(alpha, a, 5 *  Game.game.deltaTime);
		
		var dead_area:Float = 2;
		
	    canvas.rect(x, y, size, size,0,1,1,alpha);
		canvas.rect(x + Std.int(size / 2) - dead_distance, y + Std.int(size / 2) - dead_distance, dead_distance * 2 + 1, dead_distance * 2 + 1, 1,0,0,alpha);
        canvas.circle(x + Std.int((size - dead_area) / 2)+knob.x,  y + Std.int((size - dead_area) / 2)+knob.y, 10, 12, 1, 1, 1, 1);
		
	}
	
}
