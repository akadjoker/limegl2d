package;

import com.engine.components.PexParticles;
import com.engine.Game;
import com.engine.misc.Ease;
import com.engine.misc.SpriteSheet;
import com.engine.misc.Util;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;
import com.game.actions.ActionInstant;
import com.game.actions.ActionInterval;
import com.game.actions.ActionParallel;
import com.game.actions.ActionRepeat;
import com.game.actions.ActionSequence;
import com.game.actions.motion.ActionDelay;
import com.game.actions.motion.ActionFadeBy;
import com.game.actions.motion.ActionFadeIn;
import com.game.actions.motion.ActionFadeOut;
import com.game.actions.motion.ActionFadeTo;
import com.game.actions.motion.ActionMoveTo;
import com.game.actions.motion.ActionMoveBy;
import com.game.actions.motion.ActionRotateBy;
import com.game.actions.motion.ActionRotateTo;
import com.game.actions.motion.ActionScaleTo;
import com.game.gui.VirtualAnalogStick;
import com.game.gui.VirtualDPad;
import com.geom.Point;

import com.game.Actor;
import com.game.ActorLabel;
import com.game.BackGround;
import com.game.Scene;
import com.game.Sprite;
import com.engine.components.text.Text;
/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class MainGame extends Scene
{
	var player:Player;
	var act1:ActionInstant;
	var act2:ActionInterval;

	public static var particles:PexParticles;
	
	

		var sprites:SpriteSheet;
	
		var back:BackGround;
		var currtime:Int;
		var newTime:Int;

		var child:Actor;
		
	public function new() 
	{
		super("GameLoop");
	}
	override public function start():Void 
	{
		trace("start gameloop");
		sprites = new SpriteSheet();
		sprites.loadSparrow("atlas/sprites.xml", Game.game.getTexture("gfx/sprites.png"));
		//sprites.loadSparrow("assets/atlas.xml", Game.game.getTexture("assets/atlas.png"));
	
		
		add(new BackGround(getTexture("gfx/stars.jpg"), false, 2, 2, 1024, 1024, 0));
	//	add(new BackGround(getTexture("assets/stars.jpg"), false, 0, 0, 640,480, 0));
		add(new ActorLabel("atlas/tinyfont.xml", "i'm here", 1200, 300, -100));
		
		 player = new Player(sprites);
		add(player);
	
		var action:ActionSequence = new ActionSequence();
		action.addActions(
		[
	//	new ActionFadeIn(0.1), 
		new ActionDelay(1, 1), 
		//new ActionFadeOut(0.1),
		new ActionRotateTo(180, 2,Ease.bounceIn),
		new ActionDelay(1, 1), 
		new ActionRotateTo(0, 2,Ease.bounceOut),
	//	new ActionDelay(1, 1),
		
		
		]
		);
		
		var seq:ActionInstant  = new ActionRepeat(action, 0);
		
		
		for (i in 0...400)
		{
			var ship:Badship = new Badship(sprites, Util.randf(80, room.width - 80), Util.randf(80, room.height - 80), Util.randf(0, 360));
			add(ship);
		}
		
		MainGame.particles = new PexParticles("atlas/explosion.pex", "gfx/");
		
		

	//	player.runAction(seq);
		/*
	{
		child = new Actor();
		child.x = 8;
		child.y = 12;
    	child.centerx = 22 / 2;
		child.centery = 5 / 2;
		child.onUpdate = function()
		{
			child.angle = child.parent.angle;
		};
		child.addGraphic(new Sprite(sprites.image, 22, 5, 11, 4, 2, 15, -11, 11, -4, 4, [sprites.getClipbyName("red_0.png")]));
		child.parent = player;
		add(child);
	}
	
		
	{
	    child = new Actor();
		child.x = 8;
		child.y = -14;
    	child.centerx = 22 / 2;
		child.centery = 5 / 2;
		child.onUpdate = function()
		{
			child.angle = child.parent.angle;
		};
		child.addGraphic(new Sprite(sprites.image, 22, 5, 11, 4, 2, 15, -11, 11, -4, 4, [sprites.getClipbyName("red_0.png")]));
		child.parent = player;
		add(child);
	}
	*/
		setFolow(player);
		
		
	
		//virtualpad = new VirtualAnalogStick(90, game.viewHeight-120, 85, 10, 100);
		
		
		
		currtime = Game.game.getTimer();
		
	
	}
	override public function end():Void 
	{

		sprites = null;
		trace("end menu");
	}
	override public function render(batch:SpriteBatch):Void 
	{
		
		super.render(batch);
			

		
	}
	override public function update(dt:Float):Void 
	{
	super.update(dt);
	


	
	
	if (Game.game.getTimer()> currtime + 50)
	{
  	 currtime = Game.game.getTimer();
	// player.graphic.image_frame+= 1;
	}
	 
	 
	
	
	}
	
	
	
}