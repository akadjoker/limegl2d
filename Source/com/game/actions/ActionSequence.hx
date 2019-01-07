package com.game.actions;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class ActionSequence extends ActionInterval
{

	private  var actions:Array<ActionInstant>;
	private var index:Int;
	public function new() 
	{
		super(0);
		index = 0;
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
			aList[actions.length - 1 - i]= actions[i].Reverse();
		}
		var result:ActionSequence= new ActionSequence();
		result.addActions(aList);
		return result;
	}
	
	public override function Start():Void
	{
		super.Start();
		index = 0;
            actions[0].SetActor(target);
            actions[0].Start();
            while (!actions[index].running && index < actions.length - 1)
            {
                index += 1;
                actions[index].SetActor(target);
                actions[index].Start();
            }
	}
	
	public override function Stop():Void
	{
		super.Stop();
		if (actions[index].running)
                actions[index].Stop();
		
	}
	//dont override
	override public function StepTimer(dt:Float):Void 
	{
		     dt *= timeScale;
			 
		    var dtrdata:Float = 0;
            if (actions[index].running)
            {
                actions[index].StepTimer(dt);
                if (!actions[index].running)
                    dtrdata = actions[index].dtr;
            }
            while (!actions[index].running && index < actions.length - 1)
            {
                index += 1;
                actions[index].SetActor(target);
                actions[index].Start();
                if (actions[index].running && dtrdata > 0)
                    actions[index].StepTimer(dtrdata);
            }
            if (!actions[index].running)
            {
                Stop();
                dtrValue = dtrdata;
            }
	}
}