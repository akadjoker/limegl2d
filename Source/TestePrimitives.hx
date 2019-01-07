package ;

import com.engine.components.text.BitmapFont;
import com.engine.components.text.Font;
import com.engine.components.text.ImageFont;
import com.engine.components.Camera;
import com.engine.components.text.Text;
import com.engine.components.Tilemap;
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


import lime.utils.Assets;






/**
 * ...
 * @author djoker
 */
class TestePrimitives extends Screen
{
	private static var map:Array<Array<Int>> = [
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1],
		[1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1],
		[1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
		[1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1],
		[1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1],
		[1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
		[1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
	];

	
	public var primitives:BatchPrimitives;
	public var batch:SpriteBatch;
	var polygons:BatchRender;

	var tilemap:Tilemap;
	
	var image:Texture;
	var spr:Texture;
	var imfFont:Texture;
	var terrain:Texture;
	var shader:SpriteShader;
	var  bFont:BitmapFont;
	var iFont:ImageFont;
	var clips:Array<Clip>;
	var font:Text;
	
	
	public var camera:Camera;
	
	
	
		public function addVertex(x:Float, y:Float):Void
	{
		polygons.addVertex(x, y);
	}
	
	override public function show()
	{
		
		camera = new Camera(width, height);
		
		
		 shader = new SpriteShader();

		batch = new SpriteBatch(500,shader);
		batch.camera = camera;
  
		primitives = new BatchPrimitives(500);
		primitives.camera = camera;
		
		
		imfFont = getTexture("gfx/arial.png");
		
		iFont = new ImageFont(imfFont);
	
		terrain = getTexture("gfx/terrain.png");
		
		image = getTexture("gfx/block.png");
		spr = getTexture("gfx/zazaka.png");
		
		 tilemap = new Tilemap(getTexture("gfx/tiles.png"), 30 * 24, 20 * 24, 24, 24);
	
		 tilemap.loadFromString(Assets.getText("atlas/map.txt"));
		 for (i in 0 ... 10)
		{
			for (j in 0 ... 10)
			{
				 //   tilemap.setTile(i, j, Util.randi(0, 20));
					
			}
		}
		 
		
		var x:Int = 340;
		var y:Int = 250;
		
		
		polygons = new BatchRender(terrain, new SpriteShader());
		polygons.camera = camera;
		
addVertex(x+-255.00,y+-94.00);
addVertex(x+-163.00,y+-147.00);
addVertex(x+62.00,y+-188.00);
addVertex(x+183.00,y+-180.00);
addVertex(x+210.00,y+-79.00);
addVertex(x+249.00,y+-50.00);
addVertex(x+336.00,y+-111.00);
addVertex(x+344.00,y+-14.00);
addVertex(x+333.00,y+81.00);
addVertex(x+237.00,y+152.00);
addVertex(x+121.00,y+162.00);
addVertex(x+-57.00,y+186.00);
addVertex(x+-190.00,y+161.00);
addVertex(x + -297.00, y + 109.00);

polygons.Build();

		
		
		//clips = new Array<Clip>();
		//createSheet(image, 24, 24);
	}

	public  function createSheet( img:Texture, frameWidth:Int, frameHeight:Int)
	{
		var row:Int = Math.floor(img.width / frameWidth);
		var column:Int = Math.floor(img.height / frameHeight);
		for (i in 0 ... row)
		{
			for (j in 0 ... column)
			{
				    var frame:Clip = new Clip (i * frameWidth, j * frameHeight, frameWidth, frameHeight, 0, 0);
				   clips.push(frame);
					
			}
		}
	}
	
	override public function render() 
	{ 
	
	
		camera.update();
		
	//	camera.rotation += 0.1;
		

polygons.render(BlendMode.NORMAL);
	
		batch.Begin();
		
		
		var mapWidth:Int = map[0].length;
		var mapHeight:Int = map.length;
		
		for (y in 0...mapHeight)
		{
			for (x in 0...mapWidth)
			{
				//if (clips[map[y][x]]!=0) batch.RenderClip(image, x * 25, y * 25, clips[map[y][x]], false, false, BlendMode.NORMAL);
			//	if (map[y][x]!=0) batch.RenderClip(image, x * 32, y * 32, new Clip(0,0,32,32), false, false, BlendMode.NORMAL);
			}
		}
		
		tilemap.render(batch, 0, 0, 0, 0,800,800);
		
		batch.Render(spr, 800 / 2, 480 / 2, 0, 0, 64, 64, 0);
		
		iFont.print(batch, "luis santos", 200, 200);
		batch.End();
   
		primitives.begin();
        primitives.fillcircle(200, 200, 10, 12, 1, 1, 1);
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

		
	override public function mouseDown(mousex:Float, mousey:Float) 
	{
	
		
	}		
	override public function mouseMove(mousex:Float, mousey:Float) 
	{
		
		

	}
	override public function mouseUp(mousex:Float, mousey:Float) 
	{
	
	}
		


	
	
}