package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionMoveBy extends ActionInterval
{
	

	 private var delta:Point;


	
	public function new(taregetValue:Point,targetDuration:Float) 
	{
		super(targetDuration);
	
		delta = taregetValue;
		
		
	}

	 public override function Clone():ActionInstant
        {
            return new ActionMoveBy(delta, duration);
        }

        public override function Reverse():ActionInstant
        {
            return new ActionMoveBy(new Point(delta.x * -1,delta.y * -1), duration);
        }
       
		
        public override function Step(dt:Float):Void
        {
            var d:Float =  dt / duration;
			target.x +=delta.x * d;
			target.y += delta.y * d;
        }
}

