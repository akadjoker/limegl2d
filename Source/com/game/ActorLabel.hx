package com.game;
import com.engine.components.text.Text;
import com.engine.render.SpriteBatch;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class ActorLabel extends Actor
{
	private var iFont:Text;
	private var _caption:String;

	public function new(fname:String,caption:String,_x:Float,_y:Float,l:Int) 
	{
	super();
	this.layer = l;
	this.collidable = false;
	this._caption = caption;
	this.x = _x;
	this.y = _y;
	
	iFont = new Text(fname, caption);
	
		
	}
	public var caption(get, set):String;
	private inline function get_caption():String { return _caption; }
	private function set_caption(value:String):String
	{
		_caption = value;
		iFont.text = _caption;
		return _caption;
	}
	public override function render(batch:SpriteBatch):Void
	{
		iFont._green = red;
		iFont.alpha = alpha;
		iFont._red = red;
		iFont._blue = blue;
		iFont.print(batch, this.x- scene.room.viewport_x,this.y- scene.room.viewport_y);
	}
}