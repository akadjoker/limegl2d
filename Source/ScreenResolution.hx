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
class ScreenResolution extends Screen
{
    public var primitives:BatchPrimitives;
	public var batch:SpriteBatch;
	var terrain:Texture;
	var shader:SpriteShader;
	var iFont:ImageFont;
	public var camera:Camera;
	var mouse:Point;
var game_width:Float = 100; 
var game_height = 50;
var aspetc_ratio:Float;

        var worldWidth:Float;
		var worldHeight:Float;
		
	  

	
	override public function show()
	{
		
		 

		
		aspetc_ratio =  height  / width;
		
		
		//worldWidth =  game_width * aspetc_ratio;
		//worldHeight =  game_height;
	
	    worldWidth =  480 ;
		worldHeight =  320 ;
		
		
		
		camera = new Camera(width,height);
		//camera.centerRotation();
		//camera.x = game_width / 2;
		//camera.y = game_height / 2;
		camera.update();
		 
		primitives = new BatchPrimitives(500);
		primitives.camera = camera;
		
		terrain = getTexture("gfx/world.png");
		
	
		
		batch = new SpriteBatch(500,new SpriteShader());
		batch.camera = camera;

		iFont = new ImageFont(getTexture("gfx/arial.png"));
		mouse = new Point();
		
	}
	
	
		
	override public function render() 
	{ 
			
		
		camera.update();
		

			batch.Begin();

			
			//batch.RenderNormalSize(terrain, 0, 0,game_width, game_height, 1, 1, 1, 1, BlendMode.NORMAL);
		batch.RenderNormalSize(terrain, 0, 0,terrain.width,terrain.height, 1, 1, 1, 1, BlendMode.NORMAL);
			//batch.RenderNormalSize(terrain, 0, 0,1,1, 1, 1, 1, 1, BlendMode.NORMAL);
			
		iFont.print(batch, "Mouse:" + mouse.toString(), 10, height - 40);
		
			batch.End();
		
		
		primitives.begin();
		
		

		
		primitives.end();
		
		
		/*
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
		*/
		
	}
	
	public function setScreenBounds ( screenX:Int,  screenY:Int,  screenWidth:Int,  screenHeight:Int) :Void
	{
		camera.setViewPort(screenX, screenY, screenWidth, screenHeight);
	   	camera.resize(Std.int(worldWidth),Std.int( worldHeight));
	}
	
	
	  override public function resize(width:Int, height:Int) 
	{ 
	    var scaled:Point = apply(true,worldWidth, worldHeight,width, height);
		var viewportWidth = Math.round(scaled.x);
		var viewportHeight = Math.round(scaled.y);
//   	    setScreenBounds(0, 0, width, height);
		
	setScreenBounds(Std.int((width - viewportWidth) / 2),Std.int( (height - viewportHeight) / 2), viewportWidth, viewportHeight);
	}
	public function apply (fit:Bool, sourceWidth:Float,  sourceHeight:Float,  targetWidth:Float,  targetHeight:Float):Point
	{
	//	fit
	if (fit)
	{
			var targetRatio:Float = targetHeight / targetWidth;
			var sourceRatio:Float = sourceHeight / sourceWidth;
			var scale:Float = targetRatio > sourceRatio ? targetWidth / sourceWidth : targetHeight / sourceHeight;
			return new Point(sourceWidth * scale, sourceHeight * scale);
	} else
	{
		
	//	fill
			var targetRatio:Float = targetHeight / targetWidth;
			var sourceRatio:Float = sourceHeight / sourceWidth;
			var scale:Float = targetRatio < sourceRatio ? targetWidth / sourceWidth : targetHeight / sourceHeight;
			return new Point(sourceWidth * scale, sourceHeight * scale);
	}
	}

   override public function keyDown(key:Int) 
   {
	   trace(key);
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
	   
	 
   }
   
	override public function keyUp(key:Int) 
	{ 
		
		
		
	};
	
		
	override public function mouseDown(mousex:Float, mousey:Float) 
	{
	
		
	}		
	override public function mouseMove(mousex:Float, mousey:Float) 
	{
		
		
		
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
		
	
	}
		
}