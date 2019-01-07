package com.game.actions.motion;

import com.engine.misc.Ease;
import com.engine.misc.Util;
import com.game.actions.ActionInterval;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 class ActionMoveTo extends ActionInterval
{
	

	 private var m_positionDelta:Point;
	 private var m_from:Point;
	 private var m_move:Point;
	 private var time:Float;
	 private var _ease:Float -> Float;


	
	public function new(targetDelta:Point,targetDuration:Float,?ease:Float -> Float) 
	{
		super(targetDuration);
		m_positionDelta = targetDelta;
		time = 0;
		_ease = ease;
	}

	     public override function  Start():Void
        {
            super.Start();
			m_from = new Point(target.x, target.y);
			time = 0;
			m_move = new Point(m_positionDelta.x - m_from.x, m_positionDelta.y - m_from.y);
		}
		
        public override function Step(dt:Float):Void
        {
			time += dt ;
			
            var d:Float =  time / duration;
			if (_ease != null && d > 0 && d < 1) d = _ease(d);
			

	        target.x = m_from.x + m_move.x  * d;
			target.y = m_from.y + m_move.y  * d;
			 
	
        }
		
	
}

