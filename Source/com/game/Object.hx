package com.game;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

class Object extends Api
{

	
	public var graphic:Sprite;
    public var x:Float;
	public var y:Float;
	public var collidable:Bool;

	public function new() 
	{
		super();
		x = 0;
		y = 0;
		collidable = false;
		
	}
	public function addGraphic(grp:Sprite):Void
	{
		this.graphic = grp;
	}
	
}