package com.engine.components;

import com.geom.Matrix;
import com.engine.misc.Util;
/**
 * ...
 * @author djoker
 */
class Transform
{
	private var mX:Float;
	private var mY:Float;
	private var mPivotX:Float;
	private var mPivotY:Float;
	private var mScaleX:Float;
	private var mScaleY:Float;
	private var mSkewX:Float;
	private var mSkewY:Float;
	private var mRotation:Float;
    private var mTransformationMatrix:Matrix;
	private var mOrientationChanged:Bool;
	public var parent:Transform;
	
    public var x(get, set):Float;
	public var y(get, set):Float;
	public var pivotX(get, set):Float;
	public var pivotY(get, set):Float;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var skewX(get, set):Float;
	public var skewY(get, set):Float;
	public var rotation(get, set):Float;

	public function new() 
	{
		parent = null;
		mTransformationMatrix = new Matrix();
		mX = mY = mPivotX = mPivotY = mRotation = mSkewX = mSkewY = 0.0;
		mScaleX = mScaleY  = 1.0;      
		mOrientationChanged = false;

	}
	
	
		
	public function getTransformationMatrix():Matrix
	{
	
		  if (mOrientationChanged)
		{
			mOrientationChanged = false;
			
			if (mSkewX == 0.0 && mSkewY == 0.0)
			{
				
				if (mRotation == 0.0)
				{
					mTransformationMatrix.setTo(mScaleX, 0.0, 0.0, mScaleY, 
						mX - mPivotX * mScaleX, mY - mPivotY * mScaleY);
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
	public function getLocalToWorldMatrix():Matrix
    {
            if (parent == null)
            {
            return  getTransformationMatrix();
            }
           	else
            {
				
			return  getTransformationMatrix().mult(parent.getTransformationMatrix());
            }
            
       
    }
	public function dispose()
	{
		this.mTransformationMatrix = null;
		
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