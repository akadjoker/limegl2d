package com.game;
import com.engine.components.Camera;
import com.engine.misc.BlendMode;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;
/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Room 
{
	
	public var width:Float;
	public var height:Float;
	public var viewport_width:Float;
	public var viewport_height:Float;
	public var viewport_object:Actor;
	public var viewport_hborder:Float; 
	public var viewport_vborder:Float;
	public var viewport_x:Float; 
	public var viewport_y:Float;
	
	public var scenes:Array<Scene>;
	private var room_to_go:Scene;
	public var room_current:Scene;
	public var camera:Camera;
	public function new(WordlWidth:Int,WorldHeight:Int,view_width:Int, view_height:Int,view_hborder:Int, view_vborder:Int) 
	{
		
		scenes = [];
		room_to_go = null;
		
	width =WordlWidth;
	height = WorldHeight;
	
	camera = null;

	viewport_width = view_width; 
	viewport_height = view_height;
	viewport_object = null;
	viewport_hborder = view_hborder;
	viewport_vborder = view_vborder;
	viewport_x = 0; viewport_y = 0;
	}
	public function addScene(scene:Scene):Void 
	{
		scene.room = this;
		this.scenes.push(scene);
	}
	private function goto(scene:Scene):Void
	{
		room_to_go = scene;
	}
	public function go_to(id:String):Void
	{
		var ri:Int = 0;
		for (r in 0 ... scenes.length)
		{
			if (scenes[r].id == id)
			{
				ri = r;
			}
		}
		var s:Scene = scenes[ri];
		if (s != null)
		{
		 goto(s);	
		}
	}
	public function goto_next():Void
	{
		var ri:Int = 0;
		for (r in 0 ... scenes.length)
		{
			if (scenes[r] == room_current)
			{
				ri = r;
			}
		}
		var s:Scene = scenes[ri + 1];
		if (s != null)
		{
		 goto(s);	
		}
		
	}
	public function goto_previous():Void
	{
		var ri:Int = 0;
		for (r in 0 ... scenes.length)
		{
			if (scenes[r] == room_current)
			{
				ri = r;
			}
		}
		var s:Scene = scenes[ri - 1];
		if (s != null)
		{
		 goto(s);	
		}
	}
	public function goto_last():Void
	{
		goto(scenes[scenes.length-1]);
	}
	public function goto_first():Void
	{
		goto(scenes[0]);
	}
	public function restart():Void
	{
		goto(room_current);
	}
	private function switch_to(dest:Scene):Void
	{
		if (room_current != null)
		{
			room_current.room = null;
			room_current.end();
			room_current.updateLists();
		}
		room_current = dest;
		
		room_to_go = null;
		room_current.updateLists();
		room_current.start();
		room_current.updateLists();
	}
	
	public function render(batch:SpriteBatch):Void
	{
		if (room_current != null)
		{
			room_current.render(batch);
		}
	}
	public function debug(batch:BatchPrimitives):Void
	{
		if (room_current != null)
		{
			room_current.debug(batch);
		}
		
		
		var posx:Float = viewport_x;
		var posy:Float = viewport_y;
		
		
		batch.line(2-posx, 2-posy, width-2-posx, 2-posy, 1, 0, 1, 1);
		batch.line(2 - posx, height - 2, width - 2 - posx, height - 2 - posy, 1, 0, 1, 1);
		
		batch.line(2-posx, 2-posy, 2-posx, height - 2-posy, 1, 0, 1, 1);
		batch.line(width-2-posx, 2-posy, width-2-posx, height-2-posy, 1, 0, 1, 1);
		
	}
	public function update(dt:Float):Void
	{
		
		
		if (room_to_go != null)
		{
			switch_to(room_to_go);
		}
		if (room_current != null)
		{
			room_current.updateLists();
			room_current.update(dt);
			room_current.updateLists(false);
		}
		
		if (viewport_object != null) 
		{
		var _h = Math.min(viewport_hborder, viewport_width / 2);
		var _v = Math.min(viewport_vborder, viewport_height / 2);
		// hborder:
		if (viewport_object.x < viewport_x + _h) viewport_x = viewport_object.x - _h;
		if (viewport_object.x > viewport_x + viewport_width - _h) viewport_x = viewport_object.x - viewport_width + _h;
		// vborder:
		if (viewport_object.y < viewport_y + _v) viewport_y = viewport_object.y - _v;
		if (viewport_object.y > viewport_y + viewport_height - _v) viewport_y = viewport_object.y - viewport_height + _v;
		// limits:
		viewport_x = Std.int( Math.max(0, Math.min(viewport_x, width - viewport_width))) >> 0;
		viewport_y = Std.int( Math.max(0, Math.min(viewport_y, height - viewport_height))) >> 0;
		
		
	}
	
	}
	
	public function mouseMove(mousex:Int, mousey:Int) 
	{
		if (room_current != null)
		{
			room_current.mouseMove(mousex, mousey);
	
			
		}
	}	
	public function mouseUp(mousex:Int, mousey:Int) 
	{
		if (room_current != null)
		{
			room_current.mouseUp(mousex, mousey);
	
			
		}
	}
	public function mouseDown(mousex:Int, mousey:Int) 
	{ 
		if (room_current != null)
		{
			room_current.mouseDown(mousex, mousey);
	
			
		}
	}
}