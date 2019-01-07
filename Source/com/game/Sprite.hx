package com.game;
import com.engine.misc.Clip;
import com.engine.misc.Util;
import com.engine.render.Texture;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Sprite 
{

	public var width:Float;
	public var height:Float;
	public var xoffset:Float;
	public var yoffset:Float;
	public var texture:Texture;
	public var collision_shape:Int;
	public var collision_radius:Float;
	public var collision_left:Float;
	public var collision_right:Float;
	public var collision_top:Float;
	public var collision_bottom:Float;
	public var image_frame:Int;
    private var clean:Bool;
	
	
	public var frames:Array <Clip>;
	
	public function new(_tex:Texture, _width:Float, _height:Float, _xofs:Float, _yofs:Float, _cshape:Int, _crad:Float, _cl:Float, _cr:Float, _ct:Float, _cb:Float, _frames:Array<Clip>) 
	{
	
	this.texture = _tex;
	this.width = _width;
	this.height = _height;
	this.xoffset = _xofs;
	this.yoffset = _yofs;
	this.collision_shape = _cshape;
	this.collision_radius = _crad;
	this.collision_left = _cl;
	this.collision_right = _cr;
	this.collision_top = _ct;
	this.collision_bottom = _cb;
	this.frames = _frames;
	this.image_frame = 0;

	clean = false;
	}
	public function Encapsulate(x:Float, y:Float):Void
	{
		return;
		if (clean)
		{
			collision_left = x;
			collision_right = x;
			collision_top = y;
			collision_bottom = y;
			clean = false;
		} else
		{
		   if (x < collision_left)
		   {
			   collision_left = x;
		   }
		   if (x > collision_right)
		   {
			   collision_right = x;
		   }
		   if (y < collision_top)
		   {
			   collision_top = y;
		   }
		   if (y > collision_bottom)
		   {
			   collision_bottom = y;
		   }
		}
	}
	public function getFrame():Clip
	{
		if (image_frame <= 0) image_frame = 0;
		if (image_frame >= this.frames.length) image_frame = this.frames.length;
		
		return this.frames[image_frame];
	}
	public function rotate(x:Float, y:Float, xscale:Float, yscale:Float,angle:Float):Void
	{
		            
			        var arad:Float =  angle * (Math.PI / 180);
					var sina:Float = Math.sin(arad);
				    var cosa:Float = Math.cos(arad);
					
					var lsc:Float = this.collision_left * xscale;
					var rsc:Float = (this.collision_right + 1) * xscale-1;
					var tsc:Float = this.collision_top * yscale;
					var bsc:Float = (this.collision_bottom + 1) * yscale-1;
					
		var quad:Int = Std.int( Util.Modulo(Util.Modulo(Std.int(angle), 360) + 360, 360) / 90.0);

			var xsp:Int = (xscale >= 0) ? 1 : 0;
			var ysp:Int = (yscale >= 0) ? 1 : 0;
			var q12:Int = (quad == 1 || quad == 2) ? 1 : 0;
			var q23:Int = (quad == 2 || quad == 3) ? 1 : 0;
			var xs12:Int = xsp ^ q12;
			var sx23:Int = xsp ^ q23;
			var ys12:Int = ysp ^ q12;
			var ys23:Int = ysp ^ q23;
			
			
		this.collision_left   = cosa * (xs12 == 1 ? lsc : rsc) + sina * (ys23 == 1 ? tsc : bsc) + x + 0.5;
	
        this.collision_right  = cosa * (xs12 == 1 ? rsc : lsc) + sina * (ys23 == 1 ? bsc : tsc) + x + 0.5;
		
        this.collision_top    = cosa * (ys12 == 1 ? tsc : bsc) - sina * (sx23 == 1 ? rsc : lsc) + y + 0.5;
		
        this.collision_bottom = cosa * (ys12==1 ? bsc : tsc) - sina * (sx23==1 ? lsc : rsc) + y + 0.5;
		

	}
	
}