package com.game.actions;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */

  /// Runs the given action the several times. Also can repeat the action forever.
class ActionRepeat extends ActionInterval
{

	private var action:ActionInterval;
	private var count:Int;
	private var counter:Int;
	private var forever:Bool;
		
	public function new(targetAction:ActionInterval, targetCount:Int) 
	{
		super(0);
		
		    action = targetAction;
            counter = 0;
			
			if (targetCount != 0)
			{
				 count = targetCount;
                 forever = false;
				
			} else
			{
			count = 0;
            forever = true;
			}
		
	}
	public override function Clone():ActionInstant
	{
		return new ActionRepeat(cast(action.Clone(),ActionInterval), count);
	}
	 public override function Reverse():ActionInstant
        {
            return new ActionRepeat(cast(action.Reverse(),ActionInterval), count);
        }
	
	
	public override function Start():Void
	{
		super.Start();
		 action.SetActor(target);
            action.Start();
            counter = 0;
		
	}
	
	public override function Stop():Void
	{
		super.Stop();
		 if (action.running)
                action.Stop();
		
	}
	
	override public function StepTimer(dt:Float):Void 
	{
		 dt *= timeScale;
            if (action.running)
            {
                action.StepTimer(dt);
            }
            if (!action.running && (forever || counter < count - 1))
            {
                var dtrdata:Float = action.dtr;
                action.Start();
                if (dtrdata > 0)
                    action.StepTimer(dtrdata);
                counter += 1;
            }
            else if (!action.running && counter >= count - 1)
            {
                dtrValue = action.dtr;
                Stop();
            } 
			
	}

	
}