package com.game.gui;



import com.engine.Game;
import com.engine.misc.Util;
import com.engine.render.BatchPrimitives;
import com.geom.Point;


class VirtualDPad extends Uicontrol {
	// Direction that the user is pressing:
	public var isleft : Bool;
	public var isright: Bool;
	public var isup   : Bool;
	public var isdown : Bool;
public var angle: Float;
	private var _grabbed:Bool;
	private var knob:Point = new Point();
	private var _vx:Float = 0;
		private var _vy:Float = 0;
		private var _spring:Float = 400;
		private var _friction:Float = 0.0005;
	
	// To check if the user is currently using the virtual dpad at all:
	
		// Indicates that the user is interacting with the virtual dpad, because he clicked/touched it.
		// The interaction is continued until the user releases the mouse button or stops touching. It
		// is continued even while the mouse/touch position is outside of the virtual dpad.
	
	// Position and sizes:

	public var size     : Int;
	public var dead_area: Int; // No reaction inside  the "dead-area"
	public var move_area: Int; // No reaction outside the "move-area"
	
	//
	// Constructor
	//
	// x, y     : Position on screen in pixels
	// size     : Size in pixels (used for both width and height)
	// dead_area: Within this area in the center no direction is pressed
	// move_area: Outside of this area no direction is pressed
	//
	public function new( x: Float, y: Float,size: Int, dead_area: Int, move_area: Int) {
		
		  super(x,y);
		type = "JoyDPad";
	
		 
		this.size      = size;
		this.dead_area = dead_area;
		this.move_area = move_area;
		
		resetInteraction();
	}
	
	//
	// reset()
	//
	// If the interaction should be canceled, for example if your game or a level in your game restarts,
	// or if the dpad loses focus, because a window has been opened, or in any similar case, call reset().
	//
	public function reset() {
		resetInteraction();
	}
	
	// Private
	private function resetInteraction() {
		isleft  = false;
		isright = false;
		isup    = false;
		isdown  = false;
		user_is_interacting = false;
	}
	
	// Private
	private function updateDirection(mouse_x: Int, mouse_y: Int) {
		isleft  = false;
		isright = false;
		isup    = false;
		isdown  = false;
		if (user_is_interacting)
		{
			// Determine direction to that is pressed.
			// No direction inside the "dead-area" or outside the "move-area".
			if (isMouseWithinMoveArea(mouse_x, mouse_y)) 
			{
				// Left or right, depending on the mouse position:
				if (!isMouseWithinDeadAreaX(mouse_x)) {
					if (mouse_x <  x + Std.int((size - dead_area) / 2)            ) isleft  = true;
					if (mouse_x >= x + Std.int((size - dead_area) / 2) + dead_area) isright = true;
				}
				// Same of up and down:
				if (!isMouseWithinDeadAreaY(mouse_y)) {
					if (mouse_y <  y + Std.int((size - dead_area) / 2)            ) isup   = true;
					if (mouse_y >= y + Std.int((size - dead_area) / 2) + dead_area) isdown = true;
				}
				
				var mid_x: Float = x + size / 2;
				var mid_y: Float = y + size / 2;
				var dx: Float = mouse_x - mid_x;
				var dy: Float = mouse_y - mid_y;
				knob.x = dx;
				knob.y = dy;
				
			}
			
			 
				
					
				
			//trace(isleft + "<>"+isright+"<>"+isup+"<>"+isdown);
		}
	}
	
	//
	// Mouse handlers
	//
	// Call these when the mouse handlers in your Game-class are called
	//
	
	public override function mouseMove(mouse_x: Int, mouse_y: Int)
	{
		updateDirection(mouse_x, mouse_y);
	}
	
	public override function mouseDown(mouse_x: Int, mouse_y: Int) {
		if (checkMouseCollision(mouse_x, mouse_y)) 
		{
			user_is_interacting = true;
			_grabbed = true;
			updateDirection(mouse_x, mouse_y);
		}
	}
	
	public override function mouseUp(mouse_x: Int, mouse_y: Int) 
	{
		user_is_interacting = false;
		isleft  = false;
		isright = false;
		isup    = false;
		isdown  = false;
		_grabbed = false;
	}
	
	//
	// checkMouseCollision()
	//
	// Checks if the mouse or touch is on the virtual dpad.
	// Here, this is just a simple rectangle collision test.
	// If your dpad has another shape, override this function.
	//
	public function checkMouseCollision(mouse_x: Int, mouse_y: Int): Bool {
		if ((mouse_x >= x) && (mouse_y >= y) && (mouse_x < x + size) && (mouse_y < y + size)) return true;
		return false;
	}
	

	public function isMouseWithinMoveArea(mouse_x: Int, mouse_y: Int): Bool {
		if ((mouse_x >= x + Std.int((size - move_area) / 2)) && (mouse_x < x + Std.int((size - move_area) / 2) + move_area) &&
		   ((mouse_y >= y + Std.int((size - move_area) / 2)) && (mouse_y < y + Std.int((size - move_area) / 2) + move_area))) return true;
		return false;
	}
		
	public function isMouseWithinDeadAreaX(mouse_x: Int): Bool {
		if ((mouse_x >= x + Std.int((size - dead_area) / 2)) && (mouse_x < x + Std.int((size - dead_area) / 2) + dead_area)) return true;
		return false;
	}

	public function isMouseWithinDeadAreaY(mouse_y: Int): Bool {
		if ((mouse_y >= y + Std.int((size - dead_area) / 2)) && (mouse_y < y + Std.int((size - dead_area) / 2) + dead_area)) return true;
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
	}
	override public function debug(canvas:BatchPrimitives):Void
	{
		
			var a :Float= 0; 
		
		if (user_is_interacting)
		{
			a = 0.8;
		} else
		{
			a = 0.2;
			
		}
        alpha = Util.Lerp(alpha, a, 5 *  Game.game.deltaTime);

			
	    canvas.fillrect(x, y, size, size,0,1,1,a);
		canvas.rect(x + Std.int(size / 2) - dead_area, y + Std.int(size / 2) - dead_area, dead_area * 2 + 1, dead_area * 2 + 1, 1,0,0,alpha);
        canvas.circle(x + Std.int(size  / 2)+knob.x,  y + Std.int(size  / 2)+knob.y, 10, 12, 1, 1, 1, 1);
		
	}
		
}
