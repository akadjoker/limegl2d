package com.engine.misc;
import com.game.actions.motion.ActionScaleTo;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Bound
{
	public var collision_left:Float;
	public var collision_right:Float;
	public var collision_top:Float;
	public var collision_bottom:Float;
	
	public function new() 
	{
	this.collision_left = 0;
	this.collision_right = 1;
	this.collision_top = 0;
	this.collision_bottom = 1;
	}
	public function set( _cl:Float, _cr:Float, _ct:Float, _cb:Float) :Void
	{
	this.collision_left = _cl;
	this.collision_right = _cr;
	this.collision_top = _ct;
	this.collision_bottom = _cb;
	}
	public function trasform(angle:Float):Bound
	{
			        var arad:Float =  angle * (Math.PI / 180);
					var sina:Float = Math.sin(arad);
				    var cosa:Float = Math.cos(arad);
					
					var lsc:Float = this.collision_left;
					var rsc:Float = this.collision_right;
					var tsc:Float = this.collision_top;
					var bsc:Float = this.collision_bottom;
					
		var quad:Int = Std.int( Util.Modulo(Util.Modulo(Std.int(angle), 360) + 360, 360) / 90.0);

			var xsp:Int = 1;
			var ysp:Int = 1;
			var q12:Int = (quad == 1 || quad == 2) ? 1 : 0;
			var q23:Int = (quad == 2 || quad == 3) ? 1 : 0;
			var xs12:Int = xsp ^ q12;
			var sx23:Int = xsp ^ q23;
			var ys12:Int = ysp ^ q12;
			var ys23:Int = ysp ^ q23;
			
		var bound:Bound = new Bound();
		bound.collision_left   = cosa * (xs12 == 1 ? lsc : rsc) + sina * (ys23 == 1 ? tsc : bsc) +  0.5;
        bound.collision_right  = cosa * (xs12 == 1 ? rsc : lsc) + sina * (ys23 == 1 ? bsc : tsc) +  0.5;
        bound.collision_top    = cosa * (ys12 == 1 ? tsc : bsc) - sina * (sx23 == 1 ? rsc : lsc) +  0.5;
        bound.collision_bottom = cosa * (ys12 == 1 ? bsc : tsc) - sina * (sx23 == 1 ? lsc : rsc) +  0.5;
		return bound;
	}
	public function rotate(angle:Float):Void
	{
			        var arad:Float =  angle * (Math.PI / 180);
					var sina:Float = Math.sin(arad);
				    var cosa:Float = Math.cos(arad);
					
					var lsc:Float = this.collision_left;
					var rsc:Float = this.collision_right;
					var tsc:Float = this.collision_top;
					var bsc:Float = this.collision_bottom;
					
		var quad:Int = Std.int( Util.Modulo(Util.Modulo(Std.int(angle), 360) + 360, 360) / 90.0);

			var xsp:Int = 1;
			var ysp:Int = 1;
			var q12:Int = (quad == 1 || quad == 2) ? 1 : 0;
			var q23:Int = (quad == 2 || quad == 3) ? 1 : 0;
			var xs12:Int = xsp ^ q12;
			var sx23:Int = xsp ^ q23;
			var ys12:Int = ysp ^ q12;
			var ys23:Int = ysp ^ q23;
			
	
		collision_left   = cosa * (xs12 == 1 ? lsc : rsc) + sina * (ys23 == 1 ? tsc : bsc) +  0.5;
        collision_right  = cosa * (xs12 == 1 ? rsc : lsc) + sina * (ys23 == 1 ? bsc : tsc) +  0.5;
        collision_top    = cosa * (ys12 == 1 ? tsc : bsc) - sina * (sx23 == 1 ? rsc : lsc) +  0.5;
        collision_bottom = cosa * (ys12 == 1 ? bsc : tsc) - sina * (sx23 == 1 ? lsc : rsc) +  0.5;
	
	}
	/*
	public function trasform(x:Float, y:Float,cx:Float,cy:Float, xscale:Float, yscale:Float,angle:Float):Bound
	{
			        var arad:Float =  angle * (Math.PI / 180);
					var sina:Float = Math.sin(arad);
				    var cosa:Float = Math.cos(arad);
					
					var lsc:Float = this.collision_left;
					var rsc:Float = this.collision_right;
					var tsc:Float = this.collision_top;
					var bsc:Float = this.collision_bottom;
					
		var quad:Int = Std.int( Util.Modulo(Util.Modulo(Std.int(angle), 360) + 360, 360) / 90.0);

			var xsp:Int =  (xscale >= 0) ? 1 : 0;
			var ysp:Int =  (yscale >= 0) ? 1 : 0;
			var q12:Int = (quad == 1 || quad == 2) ? 1 : 0;
			var q23:Int = (quad == 2 || quad == 3) ? 1 : 0;
			var xs12:Int = xsp ^ q12;
			var sx23:Int = xsp ^ q23;
			var ys12:Int = ysp ^ q12;
			var ys23:Int = ysp ^ q23;
			
		var bound:Bound = new Bound();
		bound.collision_left   = cosa * (xs12 == 1 ? lsc : rsc) + sina * (ys23 == 1 ? tsc : bsc) + x + cx;
        bound.collision_right  = cosa * (xs12 == 1 ? rsc : lsc) + sina * (ys23 == 1 ? bsc : tsc) + x + cx;
        bound.collision_top    = cosa * (ys12 == 1 ? tsc : bsc) - sina * (sx23 == 1 ? rsc : lsc) + y + cy;
        bound.collision_bottom = cosa * (ys12 == 1 ? bsc : tsc) - sina * (sx23 == 1 ? lsc : rsc) + y + cy;
		return bound;
	}
	*/
}