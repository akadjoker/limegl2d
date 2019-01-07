package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionRotateBy extends ActionInterval
{
	 private var delta:Float;
	 public function new(targetDelta:Float,targetDuration:Float) 
  	 {
		super(targetDuration);
		delta =  targetDelta;
	 }
	
	    public override function Clone():ActionInstant
        {
            return new ActionRotateBy(delta, duration);
        }

        public override function Reverse():ActionInstant
        {
            return new ActionRotateBy(delta * -1, duration);
        }
        public override function Step(dt:Float):Void
        {
            var d:Float =  dt / duration;
			var totarget:Float = delta * d;
            target.angle = target.angle + totarget;
			
			 
        }
}

