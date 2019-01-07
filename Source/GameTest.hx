package ;


import com.engine.components.Image;
import com.engine.components.text.BitmapFont;
import com.engine.components.text.Font;
import com.engine.components.text.ImageFont;
import com.engine.components.Camera;
import com.engine.components.text.Text;
import com.engine.components.Tilemap;
import com.engine.input.Keys;
import com.engine.misc.BlendMode;
import com.engine.misc.Clip;
import com.engine.misc.Polygon;
import com.engine.misc.SpriteSheet;
import com.engine.misc.Util;
import com.engine.render.BatchRender;
import com.engine.render.filter.SpriteBlurShader;
import com.engine.render.filter.SpriteGrayShader;
import com.engine.render.filter.SpriteInvertShader;
import com.engine.render.filter.SpritePixelateShader;
import com.engine.render.filter.SpriteSepiaShader;
import com.engine.render.filter.SpriteShader;
import com.engine.render.BatchPrimitives;
import com.engine.render.filter.SpriteStepColorShader;
import com.engine.render.filter.SpriteXBlurShader;
import com.engine.render.filter.SpriteYBlurShader;
import com.engine.render.SpriteBatch;
import com.engine.render.SpriteAtlas;
import com.engine.render.SpriteCloud;
import com.engine.render.Texture;
import com.engine.Screen;
import com.engine.misc.Transitions;
import com.engine.misc.Tween;
import com.game.Room;
import com.game.Scene;
import com.game.Sprite;
import com.geom.Point;
import com.geom.Vector3D;
import lime.utils.Assets;


/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class GameTest extends Screen
{
	var times:Array<Float>;



	

    public var primitives:BatchPrimitives;

	public var batch:SpriteBatch;

	var terrain:Texture;

	var shader:SpriteShader;

	var iFont:Text;

	public var camera:Camera;

	var mouse:Point;


		

	  



		var room:Room;

		var scene:Scene;

		

	

	override public function show()

	{

		  times = [];

		 

iFont = new Text("atlas/tinyfont.xml", "Luis Santos");

	//	var g = new Graphic();

		
		
		
	

	    var w:Int =  width ;

		var h:Int =  height ;

		

		

		

		

		camera = new Camera(w,h);

		camera.update();

		

	

		

		 

		primitives = new BatchPrimitives(1500);

		primitives.camera = camera;

		

		

		

		

		

		 room = new Room(4000, 4000, w,h, 200, 200);

		 room.camera = camera;

		 room.addScene(new Menu());

		 room.addScene(new MainGame());

		 room.goto_first();

		 room.go_to("GameLoop");

		 

	

		

		batch = new SpriteBatch(1500,new SpriteShader());

		batch.camera = camera;



	

		mouse = new Point();

		

	}

	

	override public function update(dt:Float) 

	{

		

		room.update(dt);

	}

		

	override public function render() 

	{ 

		



	//	 iFont.text = "- Obj:" + room.room_current.count+"- View:"+room.room_current.numRender;

      

		

		 

		

		camera.update();

		



			batch.Begin();

		

		

		room.render(batch);

	

		

			iFont.print(batch, 10, 10);

	

			

			batch.End();

	

		

		primitives.begin();

		

	#if debug	room.debug(primitives); #end

	

	//primitives.rect(0, 0, width, height, 1, 0, 0, 1);

	//primitives.rect(0, 0, 800, 600,1,0,0,1);

	

			

			primitives.fillcircle(Std.int(game.mouse_x-camera.bound_width), Std.int(game.mouse_y-camera.bound_height),10, 22, 1, 0, 0, 1);



		

		primitives.end();

	

	

		

	}

	  override public function resize(width:Int, height:Int) 

	{ 

	    camera.resize(width, height, false);

	}

	

   override public function keyDown(key:Int) 

   {

	  

#if android

if (key == 27) 

{

Sys.exit(0);

}

#end

	 

   }

   

	override public function keyUp(key:Int) 

	{ 

		

		

		

	}

	

		

	override public function mouseDown(mousex:Float, mousey:Float) 

	{

	room.mouseDown(Std.int(mousex-camera.bound_width), Std.int(mousey-camera.bound_height));

	}		

	override public function mouseMove(mousex:Float, mousey:Float) 

	{

     room.mouseMove(Std.int(mousex-camera.bound_width), Std.int(mousey-camera.bound_height));		

     }

	override public function mouseUp(mousex:Float, mousey:Float) 

	{

	room.mouseUp(Std.int(mousex-camera.bound_width), Std.int(mousey-camera.bound_height));

	

	}

		

}