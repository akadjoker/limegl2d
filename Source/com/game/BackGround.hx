package com.game;
import com.engine.Game;
import com.engine.misc.BlendMode;
import com.engine.render.SpriteBatch;
import com.engine.render.Texture;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class BackGround extends Actor
{
	
	public var tileStretch:Bool;
	public var tileX:Int;
	public var tileY:Int;
	public var width:Int;
	public var height:Int;
	
	public var tex:Texture;
	public function new(texture:Texture,Stretch:Bool,tile_x:Int,tile_y:Int,width:Int,height:Int,l:Int) 
	{
		super();
		this.tileStretch = Stretch;
		this.tileX = tile_x;
		this.tileY = tile_y;
		this.width = width;
		this.height = height;
		this.tex = texture;
		this.x = 0;
		this.y = 0;
		this.layer = l;
		this.collidable = false;
		
		
		
	}
	public override function render(batch:SpriteBatch):Void
	{
		
	
		if (this.tileStretch)
		{
			batch.RenderNormalSize(tex, 0 - room.viewport_x, 0 - room.viewport_y, room.width, room.height,red,green,blue,alpha,blend);
			return;
		}
		
	var _bw:Int =Std.int( width);
	var _bh:Int =Std.int( height);
	var _bx:Int =Std.int(x);
	var _by:Int =Std.int(y);
	
	if (tileX!=0) 
	{ _bx = _bx < 0 ? _bw - _bx % _bw : _bx % _bw; }
	
	
	if (tileY!=0)
	{ _bx = _by < 0 ? _bh - _by % _bh : _by % _bh; }
	
	var _vx = room.viewport_x;
	var _vy = room.viewport_y;
	//var _vw = room.viewport_width;
//	var _vh = room.viewport_height;
	
	var _vw = Game.game.screenWidth;
	var _vh = Game.game.screenHeight;
	
	var _x1:Int = (tileX!=0) ? Math.floor(_vx / _bw) * _bw - _bx : -_bx;
	var _x2:Int = (tileX!=0) ? Math.floor((_vx + _vw + _bw) / _bw) * _bw : _x1 + _bw;
	var _y1:Int = (tileY!=0) ? Math.floor(_vy / _bh) * _bh - _by : -_by;
	var _y2:Int = (tileY!=0) ? Math.floor((_vy + _vh + _bh) / _bh) * _bh : _y1 + _bh;

	
	var _ht:Int = _x1;
	while (_ht < _x2)
	{
	  var _vt:Int = _y1;  
	  while (_vt < _y2)
	  {
		  
		  
		  batch.RenderNormalSize(tex, _ht -_vx , _vt -_vy, width,height,red,green,blue,alpha,blend);
		  _vt += _bh;
	  }
	  _ht += _bw;
	}
	
		
	}
	
}