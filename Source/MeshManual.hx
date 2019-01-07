package ;

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
import com.geom.Point;
import com.geom.Vector3D;


import lime.utils.Assets;


/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class MeshManual extends Screen
{
    public var primitives:BatchPrimitives;
	public var batch:SpriteBatch;
	var polygons:BatchRender;
	var terrain:Texture;
	var shader:SpriteShader;
	var iFont:ImageFont;
	public var camera:Camera;
	public var guicamera:Camera;
	var mouse:Point;
	var worldmouse:Point;
	var scx:Int;
	
	override public function show()
	{
		
		camera = new Camera(width, height);
		guicamera = new Camera(width, height);
		 
		primitives = new BatchPrimitives(500);
		primitives.camera = camera;
		
		terrain = getTexture("gfx/wood.jpg");
		
		polygons = new BatchRender(terrain, new SpriteShader());
		polygons.camera = camera;
		
		batch = new SpriteBatch(500,new SpriteShader());
		batch.camera = guicamera;
  
		scx = 0;
		
		iFont = new ImageFont(getTexture("gfx/arial.png"));
		mouse = new Point();
		worldmouse = new Point();
		
	}
	
	override public function render() 
	{ 
		
		if (game.keyboard_check(Keys.A))
		{
			trace("key down");
		}
		if (game.keyboard_check_pressed(Keys.A))
		{
			trace("presse");
		}
		if (game.keyboard_check_released(Keys.A))
		{
			trace("released");
		}
		
		
		camera.update();
		
		polygons.render(BlendMode.NORMAL);
		
		var num:Int = Std.int(polygons.numPoints());
		
		batch.Begin();
		iFont.print(batch, "Points:" + num, 10, height - 60);
		iFont.print(batch, "Mouse:" + mouse.toString(), 10, height - 40);
	//	iFont.print(batch, "World Mouse:" + worldmouse.toString(), 10, height - 20);
		
		iFont.print(batch, "Click to add points", 20, 20);
		iFont.print(batch, "Press ( Return ) to build Polygons", 20, 36);
		iFont.print(batch, "Press ( C ) to clear Polygons", 20, 52);
		
		batch.End();
		
		
		primitives.begin();
		for (i in 0... Std.int(polygons.numPoints()))
		{
			primitives.rect(polygons.pointX(i)-8, polygons.pointY(i)-8, 8,8, 1, 0, 0, 1);
		}
		
		
		for (i in 0 ... num-1 )
		{
			if (i != num-1)
			{
			primitives.line(polygons.pointX(i ), polygons.pointY(i ), polygons.pointX(i+1), polygons.pointY(i+1 ), 0, 1, 0, 1);
			
			
			
			
			}
		}
		    if (Std.int(polygons.numPoints()) > 2)
			{
			primitives.line(polygons.pointX(0 ), polygons.pointY(0 ), polygons.pointX(Std.int(polygons.numPoints())-1), polygons.pointY(Std.int(polygons.numPoints())-1 ), 0, 1, 0, 1);
			}
		

		
		primitives.end();
		
		
	}
	
	  override public function resize(width:Int, height:Int) 
	{ 
		
		var screenWidth:Int   = width;
	    var screenHeight:Int  = height;
	
	    var gameWidth:Int = 640;
		var gameHeight:Int = 480;
		
	
		
	var ar_origin:Float = (gameWidth   / gameHeight);
    var ar_new   :Float = (screenWidth /screenHeight);

    var scale_w:Float = (screenWidth / gameWidth);
    var scale_h:Float = (screenHeight / gameHeight);
    if (ar_new > ar_origin) 
	{
        scale_w = scale_h;
    } else {
        scale_h = scale_w;
    }

    var margin_x:Float = (screenWidth  - gameWidth * scale_w) / 2;
    var margin_y:Float = (screenHeight - gameHeight * scale_h) / 2;
	
	//camera.resize( gameWidth / ar_origin, gameHeight / ar_origin);
	//camera.setViewPort(Std.int (margin_x), Std.int (margin_y), Std.int (gameWidth * scale_w), Std.int (gameHeight * scale_h));

	}

   override public function keyDown(key:Int) 
   {
	   if (key == Keys.LEFT)
	   {
		   camera.x += 5;
	   } else
	   if (key == Keys.RIGHT)
	   {
		   camera.x -= 5;
	   } 
	   
	   if (key == Keys.UP)
	   {
		   camera.y -= 5;
	   } else
	   if (key == Keys.DOWN)
	   {
		   camera.y += 5;
	   } 
	   
	   
	   if (key == Keys.P)
		{
			scx++;
			polygons.scrollUV(0.001, 0);
		} else
		if (key == Keys.O)
		{
			scx--;
			polygons.scrollUV(-0.001, 0);
		}
   }
   
	override public function keyUp(key:Int) 
	{ 
		if (key == Keys.C)
		{
			polygons.Clear();
		}
		
		
		
		if (key == 13)
		{
			polygons.Build();
		}
		
		
	};
	
		
	override public function mouseDown(mousex:Float, mousey:Float) 
	{
	
		
	}		
	override public function mouseMove(mousex:Float, mousey:Float) 
	{
		
		if (mousex <= 40)
		{
			camera.x += 5;
		} else
		if (mousex >= width-40)
		{
			camera.x -= 5;
		}
		
		if (mousey <= 40)
		{
			camera.y += 5;
		} else
		if (mousey >= height-40)
		{
			camera.y -= 5;
		}
		
		
		mouse.x = mousex-camera.x;
		mouse.y = mousey-camera.y;
		//worldmouse = camera.GetTransformationMatrix().transformPoint(mouse);
	    //worldmouse =	camera.viewMatrix.deltaTransformVector(mouse);
	

	}
	override public function mouseUp(mousex:Float, mousey:Float) 
	{
		mouse.x = mousex-camera.x;
		mouse.y = mousey-camera.y;
	  //  worldmouse =	camera.viewMatrix.deltaTransformVector(mouse);
	  //worldmouse = camera.GetTransformationMatrix().transformPoint(mouse);
		
	 polygons.addVertex(mouse.x,mouse.y);
	}
		
}