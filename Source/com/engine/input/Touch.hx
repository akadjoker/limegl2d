package com.engine.input;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Touch
{
/**
	 * Touch id used for multiple touches
	 */
	public var id(default, null):Int;
	/**
	 * X-Axis coord in window
	 */
	public var x:Float;
	/**
	 * Y-Axis coord in window
	 */
	public var y:Float;
	/**
	 * The time this touch has been held
	 */
	public var time(default, null):Float;

	/**
	 * Creates a new touch object
	 * @param  x  x-axis coord in window
	 * @param  y  y-axis coord in window
	 * @param  id touch id
	 */
	public function new(x:Float, y:Float, id:Int)
	{
		this.x = x;
		this.y = y;
		this.id = id;
		this.time = 0;
	}

	
	public var pressed(get, never):Bool;
	private inline function get_pressed():Bool { return time == 0; }


	public function update()
	{
		time += Game.game.deltaTime;
	}
}