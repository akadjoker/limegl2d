package;
import com.game.Actor;


import com.engine.Game;
import com.engine.misc.SpriteSheet;
import com.engine.misc.Util;
import com.engine.render.SpriteBatch;
import com.game.Actor;
import com.game.Sprite;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Bullet extends Actor
{

	public function new(sprites:SpriteSheet,_x:Float,_y:Float,_angle:Float) 
	{
		super();
		angle = _angle;
		direction = angle;
	    addGraphic(new Sprite(sprites.image, 22, 5, 11, 4, 2, 15, -11, 11, -4, 4, [sprites.getClipbyName("red_0.png")]));
	    centerImage();
		x =  _x-centerx;
		y =  _y - centery;
		type = "bullet";
	
	}
		
	override public function update(dt:Float):Void 
	{
		advance(800,dt);
		if (outScreen())
		{
			visible = false; 
			active = false;
			
			//scene.remove(this);
		}
	}
	
}