package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionStop extends ActionInterval
{
	
	public function new() 
	{
		super();
		
		
	}
	 public override function Clone():ActionInstant
        {
            return new ActionStop();
        }
	public override function Start()
        {
            super.Start();
           target.StopAllActions();
        }
}

