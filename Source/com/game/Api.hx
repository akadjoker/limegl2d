package com.game;
import com.engine.Game;
import com.engine.misc.Util;
import com.engine.render.Texture;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Api
{
	
	public   var r2d:Float = -180 / Math.PI;
	public   var d2r:Float = Math.PI / -180;
	
	

	
		//room_background_color_show = true, room_background_color_red = 0, 
	//room_background_color_green = 0, room_background_color_blue = 0,

	
    public var game:Game;
	public function new() 
	{
		game = Game.game;
	}
	
	
public  inline function randf(max:Float, min:Float ):Float
{	
     return Math.random() * (max - min) + min;
}
public  inline function randi(max:Int, min:Int ):Int
{
	return Std.int(Math.random() * (max - min) + min);
     
}


   public inline function clamp(value:Float, min:Float, max:Float):Float
	{
		return value < min ? min : (value > max ? max : value);
	}
	
public  inline function deg2rad(deg:Float):Float
    {
        return  deg * d2r; 
    }
public  inline function rad2deg(rad:Float):Float
    {
        return rad * r2d;       
    }

	

	
	public inline function lengthdir_x(length:Float, direction:Float) { return length * Math.cos(direction * d2r); }
	public inline function lengthdir_y(length:Float, direction:Float) { return length * Math.sin(direction * d2r); }
	public inline function point_distance(x1:Float, y1:Float, x2:Float, y2:Float) { return Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2)); }
	public inline function point_direction(x1:Float,y1:Float, x2:Float, y2:Float) { return Math.atan2(y2 - y1, x2 - x1) * r2d; }	
	


public  inline function collide_bbox_bbox(l1:Float, t1:Float, r1:Float, b1:Float, l2:Float, t2:Float, r2:Float, b2:Float) :Bool
{
	return !(b1 <= t2 || t1 >= b2 || r1 <= l2 || l1 >= r2);
}
// BBox <> Point
public  inline function collide_bbox_point(l1:Float, t1:Float, r1:Float, b1:Float, x2:Float, y2:Float) :Bool
{
	return (x2 > l1 && x2 < r1 && y2 > t1 && y2 < b1);
}
// BBox <> Circle
public  inline function collide_bbox_circle(l1:Float, t1:Float, r1:Float, b1:Float, x2:Float, y2:Float, r2:Float) :Bool
{
	var dx = (x2 < l1 ? l1 : x2 > r1 ? r1 : x2) - x2, 
		dy = (y2 < t1 ? t1 : y2 > b1 ? b1 : y2) - y2;
	return (dx * dx + dy * dy < r2 * r2);
}
// Circle <> Range
public  inline function collide_circle_range(dx:Float, dy:Float, dr:Float):Bool
{
	return (dx * dx + dy * dy < dr * dr);
}
// Circle <> Circle
public  inline function collide_circle_circle(x1:Float, y1:Float, r1:Float, x2:Float, y2:Float, r2:Float) :Bool
{
	return collide_circle_range(x1 - x2, y1 - y2, r1 + r2);
}
// Circle <> Point
public  inline function collide_circle_point(x1:Float, y1:Float, r1:Float, x2:Float, y2:Float) :Bool
{
	return collide_circle_range(x1 - x2, y1 - y2, r1);
}

// BBox <> SpriteBox
// (left, top, right, bottom, instX, instY, scaleX, scaleY, sprite, ofsX, ofsY)
public  inline function collide_bbox_sbox(l1:Float, t1:Float, r1:Float, b1:Float, x2:Float, y2:Float, h2:Float, v2:Float,s2: Sprite) 
{
	return
	!( b1 <= y2 + v2 * (s2.collision_top - s2.yoffset)
	|| t1 >= y2 + v2 * (s2.collision_bottom - s2.yoffset)
	|| r1 <= x2 + h2 * (s2.collision_left - s2.xoffset)
	|| l1 <= x2 + h2 * (s2.collision_right - s2.xoffset));
}
// SpriteBox <> BBox
public  inline function collide_sbox_point(x2:Float, y2:Float, h2:Float, v2:Float, s2:Sprite, x1:Float, y1:Float):Bool 
{
	return
	!( y1 <= y2 + v2 * (s2.collision_top - s2.yoffset)
	|| y1 >= y2 + v2 * (s2.collision_bottom - s2.yoffset)
	|| x1 <= x2 + h2 * (s2.collision_left - s2.xoffset)
	|| x1 <= x2 + h2 * (s2.collision_right - s2.xoffset));
}
// SpriteBox <> Circle
public  inline function collide_sbox_circle(x2:Float, y2:Float, h2:Float, v2:Float, s2:Sprite, x1:Float, y1:Float, r1:Float):Bool
{
	var u, v, dx, dy;
	u = x2 + h2 * (s2.collision_left - s2.xoffset);
	v = x2 + h2 * (s2.collision_right - s2.xoffset);
	dx = (x2 < u ? u : x2 > v ? v : x2) - x2;
	u = y2 + v2 * (s2.collision_top - s2.yoffset);
	v = y2 + v2 * (s2.collision_bottom - s2.yoffset);
	dy = (y2 < u ? u : y2 > v ? v : y2) - y2;
	return (dx * dx + dy * dy < r1 * r1);
}

public function mouse_x():Int 
{ 
return game.mouse_x; 
}
public function mouse_y():Int 
{ 
	return game.mouse_y; 
	

}

	public inline function getTexture(url:String):Texture{return game.getTexture(url, false);}
	public inline function getTimer():Int{return game.getTimer();}
	public inline function keyboard_check(key:Int):Bool { return game.keyboard_check(key); }
	public inline function keyboard_check_pressed(key:Int):Bool { return  game.keyboard_check_pressed(key); }
	public inline function keyboard_check_released(key:Int):Bool { return game.keyboard_check_released(key);}
	public inline function mouse_check():Bool { return game.mouse_check(); }
	public inline function mouse_check_pressed():Bool { return game.mouse_check_pressed(); }
	public inline function mouse_check_released():Bool { return game.mouse_check_released(); }
}