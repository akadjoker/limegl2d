package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class ActionFadeBy extends ActionInterval
{
	
	private var delta:Float;


	public function new(targetDelta:Float,targetDuration:Float) 
	{
		super(targetDuration);
		delta = targetDelta;
	}
	public override function Step(dt:Float)
        {
   
            var d = dt / duration;
            target.alpha += delta * d;
            
        }
		public override function Clone():ActionInstant
        {
            return new ActionFadeBy(delta, duration);
        }

        public override function Reverse():ActionInstant
        {
            return new ActionFadeBy(-delta, duration);
        }
}