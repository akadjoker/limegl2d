package com.game.actions.motion;

import com.engine.misc.Util;
import com.game.actions.ActionInterval;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionRotateTo extends ActionInterval
{
	 private var value:Float;
	 private var time:Float;
	 private var _ease:Float -> Float;
	 private var from:Float;
	 private var move:Float;
	 
	 public function new(targetDelta:Float,targetDuration:Float,?ease:Float -> Float) 
  	 {
		super(targetDuration);
		value =  targetDelta;
		time = 0;
		_ease = ease;
	 }
	
	    public override function Clone():ActionInstant
        {
            return new ActionRotateTo(value, duration,_ease);
        }

		 public override function  Start():Void
        {
            super.Start();
           
			from = target.angle;
			move = value-from;
			time = 0;

        }
   
        public override function Step(dt:Float):Void
        {
    		time += dt ;
		    var d:Float =  time / duration;
			if (_ease != null && d > 0 && d < 1) d = _ease(d);
		    target.angle = from + move * d;
		 
        }
}

