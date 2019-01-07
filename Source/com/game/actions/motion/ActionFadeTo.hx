package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionFadeTo extends ActionInterval
{
	
	private var delta:Float;
	
	private var value:Float;


	public function new(targetValue:Float,targetDuration:Float) 
	{
		super(targetDuration);
		value = targetValue;
		delta = 0;
	}
	
	  public override function Start():Void
        {
            super.Start();
            delta = value - target.alpha;
        }
		
	    public override function Step(dt:Float)
        {
   
            var d = dt / duration;
            target.alpha += delta * d;
            
        }


       
}