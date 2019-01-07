package;
import com.engine.Game;
import com.engine.misc.SpriteSheet;
import com.engine.misc.Util;
import com.engine.render.SpriteBatch;
import com.game.Actor;
import com.game.Sprite;
import haxe.io.Float32Array;
import com.geom.Point;
/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Badship extends Actor
{
	

	
	var spr:SpriteSheet;

	public function new(sprites:SpriteSheet,_x:Float,_y:Float,_angle:Float) 
	{
		super();
		
		spr = sprites;
		x = _x;
		y = _y;
		angle = _angle;
		
		
	
		
		addGraphic(new Sprite(sprites.image, 56, 44, 
		56/2,44/2 ,
		2, 
		20, -56/2, 56/2, -44/2, 44/2,
		sprites.getClips("sprite_16_")));
		
		centerImage();
		
		type = "badship";
	
		  
			
		
		graphic.image_frame = 10;
	}
	
	override function update(dt:Float):Void
	{
	
		var b:Actor = place_meeting(x, y, "bullet");
		if (b != null)
		{
			b.active = false;
			active = false;
			
			var exp:Explosion = new Explosion(MainGame.particles, x+centerx, y+centery);
			scene.add(exp);
			
		}
        var b:Actor = place_meeting(x, y, "player");
		if (b != null)
		{
			active = false;
			var exp:Explosion = new Explosion(MainGame.particles, x+centerx, y+centery);
			scene.add(exp);

		}
	}
	
}