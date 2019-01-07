package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionDelay extends ActionInterval
{
	
	private var durationMin:Float;
	private var durationMax:Float;

	public function new(targetDuration:Float,targetDurationMax:Float) 
	{
		super(targetDuration);
		durationMin = targetDuration;
		durationMax = targetDurationMax;
		
	}
	public override function Start()
        {
            super.Start();
            if (durationMax != 0)
            {
                duration = Util.randf(durationMin, durationMax);
            }
        }
}

