package;

import com.engine.components.Emitter;
import com.engine.components.PexParticles;
import com.engine.Game;
import com.engine.misc.SpriteSheet;
import com.engine.misc.Util;
import com.engine.render.SpriteBatch;
import com.game.Actor;
import com.game.Sprite;
import com.geom.Matrix;
import com.geom.Point;
/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Explosion extends Actor
{
	
	var emitter:Emitter;
	
	public function new(pex:PexParticles, _x:Float,_y:Float) 
	{
		super();
		collidable = false;
		type = "explode";
		x = _x;
		y = _y;
		
	      
		  emitter = pex.createEmitter();
		 
		
	}
	
	override public function render(batch:SpriteBatch):Void 
	{
		emitter.render(x-room.viewport_x,y-room.viewport_y,batch);
	}
		
	override public function update(dt:Float):Void 
	{
			emitter.update(dt);
			
			if (!emitter.enabled)
			{
			if (emitter.numParticles<=0)
			{
				active = false;
			}
			}
	}
	
}