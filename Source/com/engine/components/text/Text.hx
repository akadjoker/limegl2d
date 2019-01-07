package com.engine.components.text;
import com.engine.components.text.Font;

import com.engine.components.text.Font.TextAlign;
import com.engine.components.text.Font.TextLayout;
import com.engine.misc.BlendMode;
import com.engine.misc.Clip;
import com.engine.render.SpriteBatch;
import com.engine.render.Texture;


import com.geom.Matrix;
import com.geom.Point;

/**
 * ...
 * @author djoekr
 */
class Text extends Graphic
{

   private var dirty:Bool = false;
   public var text (get, set) :String;
   public var font (get, set) :Font;
   public var wrapWidth:Float=0;
   public var letterSpacing:Float = 0;
   public var lineSpacing :Float = 0;
   public var align (get, set) :TextAlign;

    public function new (font :String, ?text :String = "text")
    {
        super();
        _font = new Font(font);
        _text = text;
        _align = Left;
        dirty = true;
    }
	
	 public function print(batch:SpriteBatch,x:Float,y:Float)
	{
		 updateLayout();
		 _layout.print(batch, x, y);
	}

     public function getNaturalWidth () :Float
    {
        updateLayout();
        return (wrapWidth > 0) ? wrapWidth : _layout.bounds.width;
    }

     public function getNaturalHeight () :Float
    {
        updateLayout();
        var paddedHeight = _layout.lines * (_font.lineHeight+lineSpacing);
        var boundsHeight = _layout.bounds.height;
        return Math.max(paddedHeight, boundsHeight);
    }

   

    public function setWrapWidth (wrapWidth :Float) :Text
    {
        this.wrapWidth = wrapWidth;
        return this;
    }


    public function setLetterSpacing (letterSpacing :Float) :Text
    {
        this.letterSpacing = letterSpacing;
        return this;
    }


    public function setLineSpacing (lineSpacing :Float) :Text
    {
        this.lineSpacing = lineSpacing;
        return this;
    }

    public function setAlign (align :TextAlign) :Text
    {
        this.align = align;
        return this;
    }

    inline private function get_text () :String
    {
        return _text;
    }

    private function set_text (text :String) :String
    {
        if (text != _text) 
		{
            _text = text;
        dirty = true;
        }
        return text;
    }

    inline private function get_font () :Font
    {
        return _font;
    }

    private function set_font (font :Font) :Font
    {
        if (font != _font) {
            _font = font;
         dirty = true;
        }
        return font;
    }

    inline private function get_align () :TextAlign
    {
        return _align;
    }

    private function set_align (align :TextAlign) :TextAlign
    {
        if (align != _align) {
            _align = align;
         dirty = true;
        }
        return align;
    }

    private function updateLayout ()
    {
        if (dirty = true) 
		{
                    _layout = font.layoutText(_text, _align, wrapWidth, letterSpacing, lineSpacing);
					dirty = false;
        }
    }


    private var _font :Font;
    private var _text :String;
    private var _align :TextAlign;
    private var _layout :TextLayout = null;

}
