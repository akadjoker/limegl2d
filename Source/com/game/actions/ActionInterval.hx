package com.game.actions;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

 /// Interval action class for subclassing.
class ActionInterval extends ActionInstant
{

	private var timer:Float;
	private var t:Float;
	private var timeScale:Float;
	private var dtrdata:Float;
		
	public function new(targetDuration:Float) 
	{
		super();
		 duration = targetDuration;
         timeScale = 1;
         this.dtrValue = 0;
         t = 0;
	}
	public override function Clone():ActionInstant
	{
		return new ActionInterval(duration);
	}
	
	
	public override function Start():Void
	{
		super.Start();
		 this.isRunning = true;
            timer = 0;
            t = 0;
	}
	
	public override function Stop():Void
	{
		super.Stop();
		 timer = 0;
         t = 0;
         this.isRunning = false;
	}
	//dont override
	override public function StepTimer(dt:Float):Void 
	{
		     dt *= timeScale;
             super.StepTimer(dt);
            if (timer + dt > duration)
            {
                var odt:Float = dt;
                dt = duration - timer;
                timer += odt;
            }
            else
            {
                timer += dt;
            }
            Step(dt);
            if (timer > duration)
            {
                Stop();
                this.dtrValue = timer - duration;
            }
			
	}
	//for user override
	public function Step(dt:Float):Void 
	{
		
	}
	/// Immediately changes the time scale for this action and all nested ones.
        public function SetTimeScale( ts:Float):Void
        {
            timeScale = ts;
        }
}