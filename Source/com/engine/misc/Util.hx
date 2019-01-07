package com.engine.misc;
import haxe.Timer;
import lime.system.System;

import com.geom.Rectangle;
import com.geom.Matrix;
import com.geom.Matrix3D;
import lime.graphics.Image;
import lime.math.Vector2;
import lime.utils.Assets;

import com.Vector;
import com.ByteArray;

#if neko
import sys.io.File;
import sys.io.FileOutput;
#end


/**
 * ...
 * @author djoker
 */
 class Util
{

	public static var TWO_PI:Float = Math.PI * 2.0;
	public static var DEG:Float = -180 / Math.PI;
	public static var RAD:Float = Math.PI / -180;
	public static var EPSILON:Float = 0.00000001;
	public static inline var E = 2.718281828459045;
    public static inline var LN2 = 0.6931471805599453;
    public static inline var LN10 = 2.302585092994046;
    public static inline var LOG2E = 1.4426950408889634;
    public static inline var LOG10E = 0.43429448190325176;
    public static inline var PI = 3.141592653589793;
    public static inline var SQRT1_2 = 0.7071067811865476;
    public static inline var SQRT2 = 1.4142135623730951;	
	public static inline var INT_MIN :Int = -2147483648;
    public static inline var INT_MAX :Int = 2147483647;
    public static inline var FLOAT_MIN = -1.79769313486231e+308;
    public static inline var FLOAT_MAX = 1.79769313486231e+308;
	
	
	public static var WHITE:UInt   = 0xffffff;
	public static var SILVER:UInt  = 0xc0c0c0;
	public static var GRAY:UInt    = 0x808080;
	public static var BLACK:UInt   = 0x000000;
	public static var RED:UInt     = 0xff0000;
	public static var MAROON:UInt  = 0x800000;
	public static var YELLOW:UInt  = 0xffff00;
	public static var OLIVE:UInt   = 0x808000;
	public static var LIME:UInt    = 0x00ff00;
	public static var GREEN:UInt   = 0x008000;
	public static var AQUA:UInt    = 0x00ffff;
	public static var TEAL:UInt    = 0x008080;
	public static var BLUE:UInt    = 0x0000ff;
	public static var NAVY:UInt    = 0x000080;
	public static var FUCHSIA:UInt = 0xff00ff;
	public static var PURPLE:UInt  = 0x800080;
	
		 
public static inline function getTime():Int
{
	#if flash
		return flash.Lib.getTimer ();
		#else
		return System.getTimer ();
		#end
}
inline public static function toRadians (degrees :Float) :Float
    {
        return degrees * PI/180;
    }


    inline public static function toDegrees (radians :Float) :Float
    {
        return radians * 180/PI;
    }

public static inline function randf(max:Float, min:Float ):Float
{	
     return Math.random() * (max - min) + min;
}
public static inline function randi(max:Int, min:Int ):Int
{
	return Std.int(Math.random() * (max - min) + min);
     
}

public static inline function WithinEpsilon(a:Float, b:Float):Bool {
        var num:Float = a - b;
        return -1.401298E-45 <= num && num <= 1.401298E-45;
    }
public static inline function getColorValue(color:Int):Float
	{
		var h:Int = (color >> 16) & 0xFF;
		var s:Int = (color >> 8) & 0xFF;
		var v:Int = color & 0xFF;

		return Std.int(Math.max(h, Math.max(s, v))) / 255;
	}
	

public static inline function deg2rad(deg:Float):Float
    {
        return deg / 180.0 * Math.PI;   
    }
public static inline function rad2deg(rad:Float):Float
    {
        return rad / Math.PI * 180.0;            
    }

	
     

	
public static inline function deepCopy<T>( arr : Array<T> ) : Array<T>
     {
         var r = new Array<T>();
         for( i in 0...arr.length )
             r.push(copy(arr[i]));
         return r;
     }

public static inline function copy<T>( value : Dynamic) : T {
         if( Std.is( value, Array ) )
             return cast deepCopy( value );
         else
             return value;
     }
public static inline function getExponantOfTwo(value:Int, max:Int):Int {
        var count:Int = 1;

        do {
            count *= 2;
        } while (count < value);

        if (count > max)
            count = max;

        return count;
    }
public static inline function getNextPowerOfTwo(number:Int):Int
    {
        if (number > 0 && (number & (number - 1)) == 0) // see: http://goo.gl/D9kPj
            return number;
        else
        {
            var result:Int = 1;
            while (result < number) result <<= 1;
            return result;
        }
    }
	
		

	public static inline function roundUpToPow2( number:Int ):Int
	{
		number--;
		number |= number >> 1;
		number |= number >> 2;
		number |= number >> 4;
		number |= number >> 8;
		number |= number >> 16;
		number++;
		return number;
	}
	
public static inline function isTextureOk( texture:Image ):Bool
	{
		return ( roundUpToPow2( texture.width ) == texture.width ) && ( roundUpToPow2( texture.height ) == texture.height );
	}
public static inline function getScaledDontFit( texture:Image ):Image
	{
		return if ( isTextureOk( texture ) )
		{
			texture;
		}
		else
		{
			var newTexture:Image = new Image(null, 0, 0, roundUpToPow2( texture.width ), roundUpToPow2( texture.height ), null, null);
			
			
			newTexture.copyPixels(texture, texture.rect, new Vector2(0, 0), null, null, false);
			
			//newTexture.copyPixels( texture, texture.rect, new openfl.geom.Point(), null, null, true );
			
			//texture.dispose();
			
			return newTexture;
		}
	}
	



public static inline function skew(matrix:Matrix, skewX:Float, skewY:Float)
        {
            var sinX:Float = Math.sin(skewX);
            var cosX:Float = Math.cos(skewX);
            var sinY:Float = Math.sin(skewY);
            var cosY:Float = Math.cos(skewY);
           
            setTo(matrix,matrix.a  * cosY - matrix.b  * sinX,
                         matrix.a  * sinY + matrix.b  * cosX,
                         matrix.c  * cosY - matrix.d  * sinX,
                         matrix.c  * sinY + matrix.d  * cosX,
                         matrix.tx * cosY - matrix.ty * sinX,
                         matrix.tx * sinY + matrix.ty * cosX);
        }
public static inline function setTo (matrix:Matrix, a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Void 
   {
		
		matrix.a = a;
		matrix.b = b;
		matrix.c = c;
		matrix.d = d;
		matrix.tx = tx;
		matrix.ty = ty;
		
	}
	

public static inline function createOrtho(x0:Float, x1:Float,  y0:Float, y1:Float, zNear:Float, zFar:Float) :Matrix3D
   {
      var sx:Float = 1.0 / (x1 - x0);
      var sy:Float = 1.0 / (y1 - y0);
      var sz:Float = 1.0 / (zFar - zNear);

      return new Matrix3D(Vector.ofArray ([
         2.0*sx,       0,          0,                 0,
         0,            2.0*sy,     0,                 0,
         0,            0,          -2.0*sz,           0,
         - (x0+x1)*sx, - (y0+y1)*sy, - (zNear+zFar)*sz,  1,
      ]));
   }

	
	public static function normalizeAngle(angle:Float):Float
	{
		// move to equivalent value in range [0 deg, 360 deg] without a loop
		angle = angle % TWO_PI;

		// move to [-180 deg, +180 deg]
		if (angle < -Math.PI) angle += TWO_PI;
		if (angle >  Math.PI) angle -= TWO_PI;

		return angle;
	}

   public static function clamp(value:Float, min:Float, max:Float):Float
	{
		return value < min ? min : (value > max ? max : value);
	}

	public static function convertTo3D(matrix:Matrix, resultMatrix:Matrix3D=null):Matrix3D
	{
		if (resultMatrix == null) resultMatrix = new Matrix3D();

		
		resultMatrix.rawData[ 0] = matrix.a;
		resultMatrix.rawData[ 1] = matrix.b;
		resultMatrix.rawData[ 4] = matrix.c;
		resultMatrix.rawData[ 5] = matrix.d;
		resultMatrix.rawData[12] = matrix.tx;
		resultMatrix.rawData[13] = matrix.ty;

		return resultMatrix;
	}


	public static function convertTo2D(matrix3D:Matrix3D, resultMatrix:Matrix=null):Matrix
	{
		if (resultMatrix == null) resultMatrix = new Matrix();

		resultMatrix.a  = matrix3D.rawData[ 0];
		resultMatrix.b  = matrix3D.rawData[ 1];
		resultMatrix.c  = matrix3D.rawData[ 4];
		resultMatrix.d  = matrix3D.rawData[ 5];
		resultMatrix.tx = matrix3D.rawData[12];
		resultMatrix.ty = matrix3D.rawData[13];

		return resultMatrix;
	}

		/** Returns the alpha part of an ARGB color (0 - 255). */
	public static function getAlpha(color:UInt):Int { return (color >> 24) & 0xff; }
	
	/** Returns the red part of an (A)RGB color (0 - 255). */
	public static function getRed(color:UInt):Int   { return (color >> 16) & 0xff; }
	
	/** Returns the green part of an (A)RGB color (0 - 255). */
	public static function getGreen(color:UInt):Int { return (color >>  8) & 0xff; }
	
	/** Returns the blue part of an (A)RGB color (0 - 255). */
	public static function getBlue(color:UInt):Int  { return  color        & 0xff; }
	
	/** Creates an RGB color, stored in an unsigned integer. Channels are expected
	 *  in the range 0 - 255. */
	public static function rgb(red:Int, green:Int, blue:Int):UInt
	{
		return (red << 16) | (green << 8) | blue;
	}
	
	/** Creates an ARGB color, stored in an unsigned integer. Channels are expected
	 *  in the range 0 - 255. */
	public static function argb(alpha:Int, red:Int, green:Int, blue:Int):UInt
	{
		return (alpha << 24) | (red << 16) | (green << 8) | blue;
	}
		public static inline function swap<T>(current:T, a:T, b:T):T
	{
		return current == a ? b : a;
	}
		public static inline function clear(array:Array<Dynamic>)
	{
#if (cpp || php)
		array.splice(0, array.length);
#else
		untyped array.length = 0;
#end
	}
	
		public static inline function indexOf<T>(arr:Array<T>, v:T) : Int
	{
		#if (haxe_ver >= 3.1)
		return arr.indexOf(v);
		#else
			#if (flash || js)
			return untyped arr.indexOf(v);
			#else
			return std.Lambda.indexOf(arr, v);
			#end
		#end
	}
		public static inline function next<T>(current:T, options:Array<T>, loop:Bool = true):T
	{
		if (loop)
			return options[(indexOf(options, current) + 1) % options.length];
		else
			return options[Std.int(Math.min(indexOf(options, current) + 1, options.length - 1))];
	}
	
		public static inline function prev<T>(current:T, options:Array<T>, loop:Bool = true):T
	{
		if (loop)
			return options[((indexOf(options, current) - 1) + options.length) % options.length];
		else
			return options[Std.int(Math.max(indexOf(options, current) - 1, 0))];
	}
		public static function insertSortedKey<T>(list:Array<T>, key:T, compare:T->T->Int):Void
	{
		var result:Int = 0,
			mid:Int = 0,
			min:Int = 0,
			max:Int = list.length - 1;
		while (max >= min)
		{
			mid = min + Std.int((max - min) / 2);
			result = compare(list[mid], key);
			if (result > 0) max = mid - 1;
			else if (result < 0) min = mid + 1;
			else return;
		}

		list.insert(result > 0 ? mid : mid + 1, key);
	}
	
	
	    public static inline function Lerp( value1:Float,  value2:Float,  amount:Float):Float
        {
            return value1 + (value2 - value1) * amount;
        }
		public static inline function Hermite( value1:Float,  tangent1:Float,  value2:Float,  tangent2:Float,  amount:Float):Float
        {
            var v1 = value1, v2 = value2, t1 = tangent1, t2 = tangent2, s = amount, result:Float;
            var sCubed:Float = s * s * s;
            var sSquared:Float = s * s;

            if (amount == 0)
                result = value1;
            else if (amount == 1)
                result = value2;
            else
                result = (2 * v1 - 2 * v2 + t2 + t1) * sCubed +
                    (3 * v2 - 3 * v1 - 2 * t1 - t2) * sSquared +
                    t1 * s +
                    v1;
            return result;
        }
		 public static inline function CatmullRom( value1:Float,  value2:Float,  value3:Float,  value4:Float,  amount:Float)
        {
   
            var amountSquared:Float = amount * amount;
            var amountCubed:Float = amountSquared * amount;
            return (0.5 * (2.0 * value2 +
                (value3 - value1) * amount +
                (2.0 * value1 - 5.0 * value2 + 4.0 * value3 - value4) * amountSquared +
                (3.0 * value2 - value1 - 3.0 * value3 + value4) * amountCubed));
        }
		 public static inline function SmoothStep( value1:Float,  value2:Float,  amount:Float):Float
        {
  
            var result:Float = Util.clamp(amount, 0, 1);
            result = Util.Hermite(value1, 0, value2, 0, result);

            return result;
        }

public static inline function wrapDirection(direction:Float, directions:Float):Float
{
    if (direction<0){
        direction += directions;
    }  
    if (direction >= directions){
        direction -= directions;
    }
    return direction;
}


// returns the smallest difference (value ranging between -directions/2 to +directions/2) between two angles (where 0 <= angle < directions)
public static inline function angleDiff(angle1:Float, angle2:Float, directions:Float):Float
{
    if (angle1>=directions/2){
        angle1 = angle1-directions;
    }
    if (angle2>=directions/2){
        angle2 = angle2-directions;
    }
    
    var diff:Float = angle2-angle1; 
    
    if (diff<-directions/2){
        diff += directions;
    }
    if (diff>directions/2){
        diff -= directions;
    }
    
    return diff;
}

public static inline function Modulo(n : Int, d : Int) : Int
{
    var r = n % d;
    if(r < 0) r+=d;
    return r;
}

public static inline function MatrixMult(a:Matrix,m:Matrix):Matrix {
		
		var result = new Matrix ();
		
		result.a = a.a * m.a + a.b * m.c;
		result.b = a.a * m.b + a.b * m.d;
		result.c = a.c * m.a + a.d * m.c;
		result.d = a.c * m.b + a.d * m.d;
		
		result.tx = a.tx * m.a + a.ty * m.c + m.tx;
		result.ty = a.tx * m.b + a.ty * m.d + m.ty;
		
		return result;
		
	}
}