package com.game.actions;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class ActionParallel extends ActionInterval
{
	private  var actions:Array<ActionInstant>;
	public function new() 
	{
		super(0);
		this.actions = new Array<ActionInstant>();
	}

	public function addAction(action1:ActionInstant, action2:ActionInstant):Void
	{
		this.actions.push(action1);
		this.actions.push(action2);
		
	}
	public function addActions(actionList:Array<ActionInstant>):Void
	{
		this.actions = actionList;
		
	}
	
	public override function Clone():ActionInstant
	{
	 var aList:Array<ActionInstant> = new Array<ActionInstant>();
	   for ( i in  0... actions.length)
		{
			aList[i]=actions[i].Clone();
		}
		var result:ActionSequence= new ActionSequence();
		result.addActions(aList);
		return result;
	}
	
	public override function Reverse():ActionInstant
	{
	   var aList:Array<ActionInstant> = new Array<ActionInstant>();
	   for ( i in  0... actions.length)
		{
			aList[i] = actions[i].Reverse();
		}
		var result:ActionSequence= new ActionSequence();
		result.addActions(aList);
		return result;
	}
	public override function Start():Void
	{
		super.Start();
		for ( i in  0... actions.length)
		{   actions[i].SetActor(target);
			actions[i].Start();
		}
	}
	
	public override function Stop():Void
	{
		super.Stop();
		for ( i in  0... actions.length)
		{  
			if ( actions[i].running)
		  {
			actions[i].Stop();
		   }
		}
		
	}
	//dont override
	override public function StepTimer(dt:Float):Void 
	{
		     dt *= timeScale;
			 
			 
		for ( i in  0... actions.length)
		{  
			if ( actions[i].running)
		    {
			 actions[i].StepTimer(dt);
			}
		}
		
		var canStopNow:Bool = true;
        var dtrdata:Float = 0;
		
		
		for ( i in  0... actions.length)
		{  
			if ( actions[i].running)
		    {
			canStopNow = false;
			dtrdata = Math.max(actions[i].dtrValue, dtrdata);
			}
		}
		
		
		 if (canStopNow)
            {
                Stop();
                this.dtrValue = dtrdata;
            }
			
	}
}