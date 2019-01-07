package com.engine.misc;




import haxe.xml.Fast;
import lime.utils.Assets;
import com.engine.render.Texture;

/**
 * ...
 * @author djoker
 */
class SpriteSheet
{
	public var clipsIndex:Array<Clip>;
	public var clips:Map<String,Clip>;
	public var keyFrames:Array<Clip>;
		
	public var image:Texture;
	
	public static inline var  NORMAL:Int= 0;
	public static inline var  REVERSED :Int= 1;
	public static inline var  LOOP :Int= 2;
	public static inline var  LOOP_REVERSED:Int = 3;
	public static inline var  LOOP_PINGPONG:Int = 4;
	public static inline var  LOOP_RANDOM:Int = 5;
		

	public var frameDuration:Float=0;
	public var animationDuration:Float=0;

	private var playMode:Int;
	
	public function new() 
	{
		clips = new  Map<String,Clip>();
		clipsIndex = new Array<Clip>();
		keyFrames = [];
		image = null;
		playMode = NORMAL;
	}
	public function dispose()
	{
		clips = null;
		keyFrames = null;
		clipsIndex = null;
	}
	public function addClip(name:String,c:Clip)
	{
		clips.set(name, c);
		clipsIndex.push(c);
	
	}
	
	public  function createSheet( img:Texture,name:String, frameWidth:Int, frameHeight:Int)
	{
	    this.image = img;
		var row:Int = Math.floor(img.width / frameWidth);
		var column:Int = Math.floor(img.height / frameHeight);
		var index:Int = 0;
		for (i in 0 ... row)
		{
			for (j in 0 ... column)
			{
				    var frame:Clip = new Clip (i * frameWidth, j * frameHeight, frameWidth, frameHeight, 0, 0);
				    addClip(name+"_"+index,frame);
					index++;
			}
		}
	}
	  public   function createSheetsBorder( img:Texture,name:String,frameWidth:Int, frameHeight:Int,margin:Int,spacing:Int)
	{
	    this.image = img;
		var row:Int = Math.floor(img.width / frameWidth);
		var column:Int = Math.floor(img.height / frameHeight);
		var index:Int = 0;
		for (x in 0 ... row)
		{
			for (y in 0 ... column)
			{
			var rect:Clip = new Clip();
			rect.y = y * (frameHeight + spacing);
			rect.y += margin;
			rect.height = frameHeight;
			rect.x = x * (frameWidth + spacing);
			rect.x += margin;
			rect.width = frameWidth;
			addClip(name+"_"+index,rect);
			index++;
				
			}
		}
	}
	public function parseString(str : String) : Array<Float> 
	{
		var ret : Array<Float> = new Array<Float>();
		var index : Int;
		var temp : String;
		var buf : StringBuf = new StringBuf();
		
		for (i in 0...str.length) {
			if (str.charAt(i) != "{" && str.charAt(i) != "}") {
				buf.addSub(str.charAt(i), 0);
			}
		}
		
		var newString : String = buf.toString();
		for (i in newString.split(",")) {
			ret.push(Std.parseFloat(i));
		}
		return ret;
	}

	private  function isValidElement(element:Xml):Bool
	{
		return Std.string(element.nodeType) == "element";
	}
	public function loadPlist(fname:String,path:String)
	{
			image = new Texture();
		    image.load(path);// + spriteSheetNode.get("imagePath"));
	
		parcePlist(Assets.getText(fname),image);
	
	
		
	}
	public function parcePlist(data:String, texture:Texture)
	{
		    var xmlDoc : Xml=null;
			var frames : Xml=null;
	        var metadata : Xml=null;
			
			var px:Int=0;
			var py:Int=0;
			var w:Int=0;
			var h:Int=0;
			var ox:Int=0;
			var oy:Int=0;
			var ow:Int=0;
			var oh:Int=0;
			
			xmlDoc =  Xml.parse (data);
		
		var index : Int = 0;
		for (x in xmlDoc.firstElement().firstElement().elements()) 
		{
			if (x.firstChild().nodeValue == "frames") 
			{
				index = 1;
			} else if (x.nodeName == "dict" && index == 1) 
			{
				frames = x;
			} else if (x.firstChild().nodeValue == "metadata") 
			{
				index = 2;
			} else if (x.nodeName == "dict" && index == 2) {
				metadata = x;
			}
			//trace(x.firstChild().nodeValue);
		}
		
		index = 1;
		
		var keyName:String="";
		
		var tempKey : String = "";
		for (x in frames.elements()) 
		{
			var tempEntry : Clip = new Clip();
			
			if (x.nodeName == "key" && index == 1) 
			{
				
				keyName = x.firstChild().nodeValue;
			//	trace(keyName);
				index = 2;
			} else if (x.nodeName == "dict" && index == 2) 
			{
			//	trace(x.toString());
				index = 1;
				for (info in x.elements()) 
				{
					if (info.nodeName == "key")
					{
						tempKey = info.firstChild().nodeValue;
						
						tempEntry.name = keyName;
					//	trace(tempKey);
					} else {
						switch(tempKey) {
							case "frame" : 
								var s : Array<Float> = parseString(info.firstChild().nodeValue);
								
								px = Std.int(s[0]);
								py = Std.int(s[1]);
								w = Std.int(s[2]);
								h = Std.int(s[3]);
								
								tempEntry.x = px;
								tempEntry.y = py;
								tempEntry.width = w;
								tempEntry.height = h;
								
								//break;
			                    case "offset":
								var s : Array<Float> = parseString(info.firstChild().nodeValue);
								//ox = s[0];
							//	oy = s[0];
	
								
							case "sourceColorRect":
								var s : Array<Float> = parseString(info.firstChild().nodeValue);
								ox=  Std.int(s[0]);
								oy =  Std.int(s[1]);
								ow =  Std.int(s[2]);
								oh =  Std.int(s[3]);
								
								
								
							case "rotated":
								if (info.nodeName == "true") 
								{
									tempEntry.rotated = true;
								} else {
									tempEntry.rotated = false;
								}
								
								//trace(info.nodeName);
								
						}
					}
				}
				
				if (tempEntry.rotated)
				{
					var w:Int = tempEntry.width;
					tempEntry.width = tempEntry.height;
					tempEntry.height = w;
					
					tempEntry.offsetX =Std.int( tempEntry.width -ox - ow);
					tempEntry.offsetY = Std.int(tempEntry.height - oy - oh);
					
					
				} else
				{
						tempEntry.offsetX =Std.int( ox);
					    tempEntry.offsetY =Std.int( tempEntry.height - oy - oh);
			
				}
				
			 	// trace(tempEntry.toString());
				 addClip(keyName,tempEntry);
		
			}
		}
		//trace(frames.firstElement().firstChild().nodeValue);
	}
	public function loadSparrow(data:String, texture:Texture)
	{

	
		var xml:Xml = Xml.parse (Assets.getText(data));
		var spriteSheetNode = xml.firstElement();
		var initFrameX = 0;
		var initFrameY = 0;
		var offsetFrameX = 0;
		var offsetFrameY = 0;
		var name:String="";
		var i = 0;
		

		
		image = texture;

		for (frameNode in spriteSheetNode.elements()) 
		{
			
			var frameNodeFast = new Fast(frameNode);
		
			
			  if (frameNodeFast.has.frameX)
				{
					//initFrameX = Std.parseInt ( frameNodeFast.att.frameX );
					offsetFrameX = Std.parseInt (frameNodeFast.att.frameX);// - initFrameX;
					//offsetFrameX = Std.parseInt (frameNodeFast.att.frameX);
				//	trace(offsetFrameX);
				}
				if (frameNodeFast.has.frameY)
				{
					//trace(frameNodeFast.att.frameY);
					//initFrameY = Std.parseInt ( frameNodeFast.att.frameY );
					offsetFrameY = Std.parseInt (frameNodeFast.att.frameY);// - initFrameY;
					//offsetFrameY = Std.parseInt (frameNodeFast.att.frameY) ;
				//	trace(offsetFrameY);
				}
	
	
				name = frameNodeFast.att.name;
			   var frame:Clip = new Clip (
			   Std.parseInt (frameNodeFast.att.x),
			   Std.parseInt (frameNodeFast.att.y),
			   Std.parseInt (frameNodeFast.att.width),
			   Std.parseInt (frameNodeFast.att.height),
			  offsetFrameX,
			  offsetFrameY, name);
			   
			 //   trace(frame.toString());
				  
			    addClip(name,frame);
			
		}
		
		

	}
	public function parseSparrow(data:String, path:String)
	{

		var xml:Xml = Xml.parse (data);
		var spriteSheetNode = xml.firstElement();
		var initFrameX = 0;
		var initFrameY = 0;
		var offsetFrameX = 0;
		var offsetFrameY = 0;
		var name:String="";
		var i = 0;
		

		
		image = new Texture();
		
		
		//trace(spriteSheetNode.get("imagePath"));
		image.load(path + spriteSheetNode.get("imagePath"));
		

		for (frameNode in spriteSheetNode.elements()) 
		{
			
			var frameNodeFast = new Fast(frameNode);
		
			
			  if (frameNodeFast.has.frameX)
				{
					initFrameX = Std.parseInt ( frameNodeFast.att.frameX );
					offsetFrameX = Std.parseInt (frameNodeFast.att.frameX) - initFrameX;
				}
				if (frameNodeFast.has.frameY)
				{
					initFrameY = Std.parseInt ( frameNodeFast.att.frameY );
					offsetFrameY = Std.parseInt (frameNodeFast.att.frameY) - initFrameY;
				}
	
	
				name = frameNodeFast.att.name;
			   var frame:Clip = new Clip (
			   Std.parseInt (frameNodeFast.att.x),
			   Std.parseInt (frameNodeFast.att.y),
			   Std.parseInt (frameNodeFast.att.width),
			   Std.parseInt (frameNodeFast.att.height),
			   -offsetFrameX,
			   -offsetFrameY);
			   
			trace(frame);
			   
			    addClip(name,frame);
			
		}
		
		

	}
	public function loadSWFCorona(fname:String,path:String)
	{
		parseXMLSFWCorona(Assets.getText(path+fname),path);
	}
	private  function parseXMLSFWCorona (data:String,path:String):Void 
		{
		var frameIndex:Map <String,Int> = new Map <String,Int> ();
		
		var xml:Xml = Xml.parse (data);
		var spriteSheetNode:Xml = xml.firstElement ();
		
		image = new Texture();
		image.load(path + spriteSheetNode.get("path"));
		
		var name:String = spriteSheetNode.get("name");
		
        var index:Int = 0;
		
		for (behaviorNode in spriteSheetNode.elements ()) 
		{

			var behaviorNodeFast:Fast = new Fast (behaviorNode);
			var behaviorFrames:Array <Int> = new Array <Int> ();
			
			var allFramesText:String = behaviorNodeFast.innerData;
			var framesText:Array <String> = allFramesText.split (";");
			
			for (frameText in framesText) 
			{
				if (!frameIndex.exists (frameText)) 
				{
					var components:Array < String > = frameText.split (",");
				    var frame:Clip = new Clip (
					Std.parseInt (components[0]), 
					Std.parseInt (components[1]), 
					Std.parseInt (components[2]), 
					Std.parseInt (components[3]), 
					-Std.parseInt (components[4]), 
					-Std.parseInt (components[5]));
				  
					//   trace(frame.toString());
					   
					addClip(name + "_" + index, frame);
					index++;
				}
			}
		}
	}


	public function getClip(index:Int):Clip
	{
	 return clipsIndex[index];
	}
	public function getClipbyName(name:String):Clip
	{
	 return clips.get(name);
	}	
	public function setFrameDuration(value:Float)
	{
		frameDuration = value;
		animationDuration = numFrames() * frameDuration;
	}
	public function getFrames (stateTime:Float,looping:Bool) :Clip
	{
		if (looping && (playMode == NORMAL || playMode == REVERSED)) 
		{
			if (playMode == NORMAL)
				playMode = LOOP;
			else
				playMode = LOOP_REVERSED;
		} else if (!looping && !(playMode == NORMAL || playMode == REVERSED))
		{
			if (playMode == LOOP_REVERSED)
				playMode = REVERSED;
			else
				playMode = LOOP;
		}

		return getKeyFrame(stateTime);
	}
	public function numFrames():Int
	{
		return keyFrames.length;
	}
	public function getKeyFrame (stateTime:Float):Clip 
	{
		var frameNumber:Int = Std.int(stateTime / frameDuration);


       switch (playMode) 
	   {
		case SpriteSheet.NORMAL:
			frameNumber = Std.int(Math.min(keyFrames.length - 1, frameNumber));
		case SpriteSheet.LOOP:
			frameNumber = frameNumber % keyFrames.length;
		case SpriteSheet.LOOP_PINGPONG:
			frameNumber = frameNumber % (keyFrames.length * 2);
			if (frameNumber >= keyFrames.length) frameNumber = keyFrames.length - 1 - (frameNumber - keyFrames.length);
		case SpriteSheet.LOOP_RANDOM:
			frameNumber =Std.int( Math.random()*(keyFrames.length - 1));
		case SpriteSheet.REVERSED:
			frameNumber = Std.int(Math.max(keyFrames.length - frameNumber - 1, 0));
		case SpriteSheet.LOOP_REVERSED:
			frameNumber = frameNumber % keyFrames.length;
			frameNumber = keyFrames.length - frameNumber - 1;
		default:
			frameNumber =Std.int( Math.min(keyFrames.length - 1, frameNumber));

		}
		return keyFrames[frameNumber];
	}

	     public function getClips(prefix:String=""):Array<Clip>
        {
            var result:Array<Clip>= [];
            var names:Array<String> = getNames(prefix);
			for (name in names)
			{
				
				if (clips.exists(name))
				{
					//	trace(name+ "  exits");
					result.push(clips.get(name));
				}
				else
				{
					trace(name+ " dont exits");
				}
			}
            return result;
        }
		
		public function createAnimationFromAll(fps:Float,playermode:Int)
		{
			this.playMode = playermode;
			frameDuration = fps;
			keyFrames = [];
		
			for (c in 0 ... clipsIndex.length)
			{
					keyFrames.push(clipsIndex[c]);
				
			}
	
		}
		public function createAnimation(fps:Float,prefix:String = "",playermode:Int)
		{
			this.playMode = playermode;
			frameDuration = fps;
			keyFrames = [];
			var names:Array<String> = getNames(prefix);
			for (name in names)
			{
				if (clips.exists(name))
				{  
					keyFrames.push(clips.get(name));
					
				} 
			}
			names=null;
		}
      public function getNames(prefix:String=""):Array<String>
        {
            var result:Array<String> = [];
			
			for (name in clips.keys())
			{
				 if (name.indexOf(prefix) == 0)
				 {
					 result.push(name);
				 }
			}
			
			result.sort( function strSort(a:String, b:String):Int
             {
             a = a.toLowerCase();b = b.toLowerCase();
             if (a < b) return -1;if (a > b) return 1;return 0;} );
			 
			 
			return result;

        }
	
}

/*
SNIPET

 sprites = new SpriteSheet();
		sprites.loadPlist("atlas/a-hd.plist", "gfx/a-hd.png");
		//sprites.loadPlist("atlas/explosion.plist", "gfx/explosion.png");
		//sprites.loadSparrow("atlas/atlas.xml", getTexture("gfx/atlas.png"));
		sprites.createAnimation(200, "a", 2);
	//	sprites.setFrameDuration(30);
		//sprites.createAnimation(100, "flight",2);
		
	var clip:Clip =  sprites.getFrames(HXP.getTimer(), true);// x:120, y: 58, w:52, h: 116, offx: 39, offy:0 sprites.getClip(0); //sprites.getFrames(HXP.getTimer(), true);
		var angle:Float = 0;
		if (clip.rotated)
		angle = -90;
	//	batch.RenderScaleRotateClipColorAlpha(sprites.image, 200-clip.offsetX, 200-(clip.offsetY+clip.height),1,1,angle, clip,1,1,1,1,0);
		batch.drawImageEx(sprites.image, 200+clip.offsetX,100-clip.offsetY,clip.width,clip.height,1,1,angle,clip.width/2,clip.height/2, clip,false,false,1,1,1,1,0);


*/