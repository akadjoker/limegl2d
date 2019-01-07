package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionFadeIn extends ActionFadeTo
{
	public function new(targetDuration:Float) 
	{
		super(1,targetDuration);
	}
	 public override function Start():Void
        {
           super.Start();
           target.alpha = 0;
        }
		
	   public override function Clone():ActionInstant
        {
            return new ActionFadeIn(duration);
        }

        public override function Reverse():ActionInstant
        {
            return new ActionFadeOut(duration);
        }



       
}