package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionFadeOut extends ActionFadeTo
{
	public function new(targetDuration:Float) 
	{
		super(0,targetDuration);
	}
	public override function Clone():ActionInstant
        {
            return new ActionFadeOut(duration);
        }

        public override function Reverse():ActionInstant
        {
            return new ActionFadeIn(duration);
        }



       
}