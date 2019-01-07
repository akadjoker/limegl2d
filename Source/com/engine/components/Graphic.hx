package com.engine.components;
import com.engine.misc.Util;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Graphic
{
	
    private var mScale:Float;
    public var _alpha:Float;
	private var _color:Int;
	public var _red:Float;
	public var _green:Float;
	public var _blue:Float;
	
	public function new() 
	{
	_color = 0x00FFFFFF;
   _alpha=_red = _green = _blue = 1;
    mScale = 1;
	}
	
	public var scale(get, set):Float;
	private function get_scale():Float { return mScale; }
	private function set_scale(value:Float):Float 
	{ 
		if (mScale != value)
		{
			mScale = value;
		}
		return value;
	}
    public var alpha(get, set):Float;
	private function get_alpha():Float { return _alpha; }
	private function set_alpha(value:Float):Float
	{
		value = value < 0 ? 0 : (value > 1 ? 1 : value);
		if (_alpha == value) return value;
		_alpha = value;
		return _alpha;
	}	
	public var color(get, set):Int;
	private function get_color():Int { return _color; }
	private function set_color(value:Int):Int
	{
		value &= 0xFFFFFF;
		if (_color == value) return value;
		_color = value;
		_red = Util.getRed(_color) / 255;
		_green = Util.getGreen(_color) / 255;
		_blue = Util.getBlue(_color) / 255;
		return _color;
	}
}