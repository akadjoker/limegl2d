package com.engine.components;

import com.engine.Game;
import com.engine.misc.Util;

import lime.utils.Float32Array;
import  lime.graphics.opengl.GL;

import com.geom.Rectangle;
import com.geom.Matrix;
import com.geom.Matrix3D;
import com.geom.Point;




/**
 * ...
 * @author djoker
 */
class Camera 
{
	private var mTransformationMatrix:Matrix;
	 public var projMatrix:Matrix3D;
	 public var viewMatrix:Matrix3D;
	 private var width:Float;
	 private var height:Float;
     private var mX:Float;
	 private var mY:Float;
	 private var mPivotX:Float;
	 private var mPivotY:Float;
	 private var mScaleX:Float;
	 private var mScaleY:Float;
	 private var mSkewX:Float;
	 private var mSkewY:Float;
	 private var mRotation:Float;
	 private var mOrientationChanged:Bool;
	 private var viewport:Rectangle;
	
	private var gameWidth :Float;
	private	var gameHeight:Float;
		

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var pivotX(get, set):Float;
	public var pivotY(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var skewX(get, set):Float;
	public var skewY(get, set):Float;
	public var rotation(get, set):Float;
	
	
	public var bound_width:Int;
	public var bound_height:Int;
	public var viewportWidth:Int;
	public var viewportHeight:Int;
	
	public function new(screen_width:Int, scree_height:Int, ?game_width:Int=0,?game_height:Int=0) 
	{
		mX = mY = mPivotX = mPivotY = mRotation = mSkewX = mSkewY = 0.0;
		mScaleX = mScaleY  = 1.0;       
		mTransformationMatrix = new Matrix();
		viewport = new Rectangle(0, 0, screen_width,scree_height);
		projMatrix = Util.createOrtho(0, screen_width, scree_height, 0,  -100, 100);
		this.width = screen_width;
		this.height = scree_height;
		if (game_width == 0)
		{
			this.gameWidth = screen_width;
		} else
		{
			this.gameWidth = game_width;
		}
		if (game_height == 0)
		{
			this.gameHeight = scree_height;
		}else
		{
			this.gameHeight = game_height;
		}
		viewportWidth = 0;
		viewportHeight = 0;
		bound_width = 0;
		bound_height = 0;
		viewMatrix = new Matrix3D();
		mOrientationChanged = true;
		//centerRotation();
		update();
	}

	public function centerRotation():Void
	{
		x = width / 2;
		y = height / 2;
		pivotX = width / 2;
		pivotY = height / 2;
	}

	public function update()
	{
         GL.viewport (Std.int (viewport.x), Std.int (viewport.y), Std.int (viewport.width), Std.int (viewport.height));
		 if (mOrientationChanged)
		 {
			Util.convertTo3D(GetTransformationMatrix(), viewMatrix);
		    mOrientationChanged = false;
		 }
		 
  
		
	}
	
	
	public function GetTransformationMatrix():Matrix
	{
		if (mOrientationChanged)
		{
			mOrientationChanged = false;
			
			if (mSkewX == 0.0 && mSkewY == 0.0)
			{
				
				if (mRotation == 0.0)
				{
					mTransformationMatrix.setTo(mScaleX, 0.0, 0.0, mScaleY,mX - mPivotX * mScaleX, mY - mPivotY * mScaleY);
				}
				else
				{
					var cos:Float = Math.cos(mRotation);
					var sin:Float = Math.sin(mRotation);
					var a:Float   = mScaleX *  cos;
					var b:Float   = mScaleX *  sin;
					var c:Float   = mScaleY * -sin;
					var d:Float   = mScaleY *  cos;
					var tx:Float  = mX - mPivotX * a - mPivotY * c;
					var ty:Float  = mY - mPivotX * b - mPivotY * d;
					mTransformationMatrix.setTo(a, b, c, d, tx, ty);
				}
			}
			else
			{
				mTransformationMatrix.identity();
				mTransformationMatrix.scale(mScaleX, mScaleY);
				Util.skew(mTransformationMatrix, mSkewX, mSkewY);
				mTransformationMatrix.rotate(mRotation);
				mTransformationMatrix.translate(mX, mY);
				
				if (mPivotX != 0.0 || mPivotY != 0.0)
				{
				
					mTransformationMatrix.tx = mX - mTransformationMatrix.a * mPivotX
												  - mTransformationMatrix.c * mPivotY;
					mTransformationMatrix.ty = mY - mTransformationMatrix.b * mPivotX 
												  - mTransformationMatrix.d * mPivotY;
				}
			}
		}
		
		return mTransformationMatrix; 
	}
	public function setViewPort(x:Int, y:Int, w:Int, h:Int):Void
	{
    	  viewport.setTo(x, y, w, h);
		 
	}
	public function setOrtho(width:Float, height:Float) 
	{
	this.width = width;
	this.height = height;
	projMatrix = Util.createOrtho(0, width, height, 0,  -100, 100);
	}
	 
	public function setScreenBounds ( screenX:Int,  screenY:Int,  screenWidth:Int,  screenHeight:Int) :Void
	{
		setViewPort(screenX, screenY, screenWidth, screenHeight);
	   	setOrtho(Std.int(screenWidth),Std.int( screenHeight));
	}
	
	
	 public function resize(width:Int, height:Int,?fit:Bool=true) 
	{

	    var scaled:Point = apply(fit,gameWidth, gameHeight,width, height);
		viewportWidth = Math.round(scaled.x);
		viewportHeight = Math.round(scaled.y);
		bound_width = Std.int((width - viewportWidth) / 2);
		bound_height = Std.int( (height - viewportHeight) / 2);
  	    
		setScreenBounds(Std.int((width - viewportWidth) / 2), Std.int( (height - viewportHeight) / 2), viewportWidth, viewportHeight);

		
	}
	private function apply (fit:Bool, sourceWidth:Float,  sourceHeight:Float,  targetWidth:Float,  targetHeight:Float):Point
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
	
	
	private function get_x():Float { return mX; }
	private function set_x(value:Float):Float 
	{ 
		if (mX != value)
		{
			mX = value;
			mOrientationChanged = true;
		}
		return value;
	}
	private function get_y():Float { return mY; }
	private function set_y(value:Float):Float 
	{
		if (mY != value)
		{
			mY = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_pivotX():Float { return mPivotX; }
	private function set_pivotX(value:Float):Float 
	{
		if (mPivotX != value)
		{
			mPivotX = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_pivotY():Float { return mPivotY; }
	private function set_pivotY(value:Float):Float 
	{ 
		if (mPivotY != value)
		{
			mPivotY = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_scaleX():Float { return mScaleX; }
	private function set_scaleX(value:Float):Float 
	{ 
		if (mScaleX != value)
		{
			mScaleX = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_scaleY():Float { return mScaleY; }
	private function set_scaleY(value:Float):Float 
	{ 
		if (mScaleY != value)
		{
			mScaleY = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_skewX():Float { return mSkewX; }
	private function set_skewX(value:Float):Float 
	{
		value = Util.normalizeAngle(value);
		
		if (mSkewX != value)
		{
			mSkewX = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_skewY():Float { return mSkewY; }
	private function set_skewY(value:Float):Float 
	{
		value = Util.normalizeAngle(value);
		
		if (mSkewY != value)
		{
			mSkewY = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
	private function get_rotation():Float { return mRotation; }
	private function set_rotation(value:Float):Float 
	{
		value = Util.normalizeAngle(value);
		if (mRotation != value)
		{            
			mRotation = value;
			mOrientationChanged = true;
		}
		return value;
	}
	
}