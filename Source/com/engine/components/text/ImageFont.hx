package com.engine.components.text;

import com.engine.misc.BlendMode;
import com.engine.misc.Clip;
import com.engine.render.SpriteBatch;
import com.engine.render.Texture;







/**
 * ...
 * @author djoker
 */
class ImageFont extends Graphic
{




public var image:Texture;
private var offsetX:Int;
private var offsetY:Int;

public var characterWidth:Int;
public var characterHeight:Int;
private var characterSpacingX:Int;
private var characterSpacingY:Int;
private var characterPerRow:Int;
private var glyphs:Array<Clip>;
private var align:Int;




public var customSpacingX:Int;
public var customSpacingY:Int;





public function new( tex:Texture, ?clipWidth:Int = 16, ?clipHeight:Int=16, ?trim:Int = 0):Void
{
super();


align = 0;
customSpacingX = 0;
customSpacingY = 0;


image = tex;


characterWidth  =   Std.int( image.width / clipWidth);
characterHeight =   Std.int( image.height / clipHeight);
characterSpacingX = 0;
characterSpacingY = 0;
characterPerRow =  Std.int(image.width / characterWidth);
offsetX = 0;
offsetY = 0;

glyphs = new Array<Clip>();


var currentX:Int = offsetX;
var currentY:Int = offsetY;
var r:Int = 0;
var index:Int = 0;

for(c in 30...200)
//for(c in 30...150)
{
glyphs[index++] = new Clip(currentX, currentY, characterWidth, characterHeight);
r++;
if (r == characterPerRow)
{
r = 0;
currentX = offsetX;
currentY += characterHeight + characterSpacingY;
}
else
{
currentX += characterWidth + characterSpacingX;
}
}

}


public function getTextWidth(caption:String):Int 
	{
		var w:Int = 0;
		var textLength:Int = caption.length;
		for (i in 0...(textLength)) 
		{
        var glyph = glyphs[caption.charCodeAt(i)];
		if (glyph != null) 
			{
				w += characterWidth;
			
			}
		w = Math.round(w * scale);
		if (textLength > 1)
		{
			w += (textLength - 1) * characterSpacingX;
		}
		}
		return w;
	}

public function print(batch:SpriteBatch,caption:String, x:Float, y:Float,?align:Int=0)
{

	var cx:Int = 0;
	var cy:Int = 0;
	var X:Float = x;
	var Y:Float = y;
	

	var newLine:Float = characterHeight + characterSpacingY;

	   switch (align) 
       { 
       case 0:
       cx = 0;
       case 1:
       cx = getTextWidth(caption);
       case 2:
       cx = Std.int(getTextWidth(caption) / 2);
       }
	   


  for (c in 0...caption.length)   
   {
    if(caption.charAt(c) == " ")
    {
       X +=characterWidth + customSpacingX;
	   
    }
    else
	  if(caption.charAt(c) == "\n")
    {
	   Y += newLine;	
       X = x-characterWidth + customSpacingX;
    } else
      {
        var glyph = glyphs[caption.charCodeAt(c)];
        X += characterWidth + customSpacingX;
     if (glyph != null) batch.RenderFont(image, (X - cx) - characterWidth, Y, scale, glyph, false, true, _red, _green, _blue, alpha, BlendMode.NORMAL);
		 
     }
  }
}

	
}