package com.game.actions;
import com.game.Actor;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class ActionInstant
{
	public var unstopable:Bool = false;
    public var target:Actor;
    private var durationValue:Float = 0;
    private var dtrValue:Float = 0;
    private var isRunning:Bool = false;
		
	public function new() 
	{
		
	}
	
	public function Clone():ActionInstant
	{
		return new ActionInstant();
	}
	
	public function Reverse():ActionInstant
	{
	 trace('override me');
	return null;
	}
	public function Start():Void
	{
		if (target == null)
		{
	     trace("actor not set");
		}
	}
	public function Stop():Void
	{
		if (target == null)
		{
	     trace("actor not set");
		}
	}
	public function StepTimer(ft:Float):Void
	{
		if (target == null)
		{
	     trace("actor not set");
		}
	}
	public function SetActor(a:Actor):Void
	{
	this.target = a;
	}
	
	public var duration(get, set):Float;
	private inline function get_duration():Float 
	{ 
	return durationValue; 
	}
	private inline function set_duration(value:Float):Float
	{
        durationValue = value;		
		return durationValue;
	}
	
	public var running(get, never):Bool;
	private inline function get_running():Bool 
	{ 
	return isRunning; 
	}

	
   /// Readonly property. Contains the remaining tick time after action finished.
    public var dtr(get, never):Float;
	private inline function get_dtr():Float 
	{ 
	return dtrValue; 
	}
}