package com.game;
import com.engine.Game;
import com.engine.misc.BlendMode;
import com.engine.misc.Bound;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;
import com.game.actions.ActionInterval;
import com.game.actions.ActionInstant;
import com.geom.Point;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
@:allow(com.game.Scene)
class Actor extends Object
{
		
	private var bound:Bound;
	
    public var showBound:Bool;
	public var parent:Actor;
	public var active:Bool;
	public var visible:Bool;
	public var sleep:Bool;
	public var flipx:Bool;
	public var flipy:Bool;
	
	public var xscale:Float;
	public var yscale:Float;
	public var red:Float;
	public var green:Float;
	public var blue:Float;
	public var alpha:Float;
	public var blend:Int;
	
	public var centerx:Float;
	public var centery:Float;
	public var angle:Float;
	public var direction:Float;
	public var speed:Float;
	
	public var room:Room;
	
	public var onUpdate:Void -> Void;
	public var onBegin:Void -> Void;
	public var onEnd:Void -> Void;

	

	public function new() 
	{
		super();
		active = true;
		visible = true;
		sleep = false;
        flipx = false;
        flipy = false;
        angle = 0;
		red = 1;
		green = 1;
		blue = 1;
		alpha = 1;
		blend = BlendMode.NORMAL;
		direction = 0;
		speed = 0;
		centerx = 0;
		centery = 0;
		xscale = 1;
		yscale = 1;
		_type = "";
		_name = "";
		layer = 0;
		showBound = false;
		collidable = true;
		_class = Type.getClassName(Type.getClass(this));
		parent = null;
		
		paused=false;
        running=false;
        numActions = 0;
		 actions = new List<ActionInstant>();
         actionsToDelete= new List<ActionInstant>();
         actionsToAdd= new List<ActionInstant>();

		 bound = new Bound();

	}
	public function Destroy():Void
	{
		graphic = null;
		onBegin = null;
		onEnd = null;
		onUpdate = null;
	}
	
	public function start():Void
	{
		
	}
	public function end():Void
	{
		
	}
	public function updateActions(dt:Float):Void
	{
		
        if (paused)
            return;
			
	    numActions = actions.length;
		
		for (action in actions)
		{
			if (action.running)
			{
				action.StepTimer(dt);
			}
			if (!action.running)
			{
				actionsToDelete.add(action);
			}
		}
			 
		
	
    
		

	
		
	}
	public function LateUpdate():Void
	{
		
			if (this.graphic != null)
			{
	bound.set( 
	    this.graphic.collision_left,
		this.graphic.collision_right ,
		this.graphic.collision_top,
		this.graphic.collision_bottom );
	    bound.rotate(angle);
			}
	
		for ( action in actionsToAdd)
        {
            if (action.running)
                actions.add(action);
        }
        for ( action in actionsToDelete)
        {
            if (!action.running)
                actions.remove(action);
        }
        actionsToDelete.clear();
        actionsToAdd.clear();
        running = actions.length > 0;
	}
	public function runAction( targetAction:ActionInstant):Void
    {
        targetAction.SetActor(this);
        targetAction.Start();
        if (targetAction.running)
        {
            actionsToAdd.add(targetAction);
        }
    }


    public function RemoveAction( targetAction:ActionInstant):Void
    {
        if (targetAction.running)
            targetAction.Stop();
    }

  
    public function StopAllActions():Void
    {
        for ( action in actions)
        {
            if (action.running && !action.unstopable)
                action.Stop();
        }
    }


    public function PauseActions():Void
    {
        paused = true;
    }

    public function UnpauseActions():Void
    {
        paused = false;
    }

 
    /// Sets the timescale for current action.

    public function SetTimeScale(ts:Float):Void
    {
		
        for ( action in actions)
        {
            if (Std.is(action, ActionInterval))
			{
				var a:ActionInterval = cast(action, ActionInterval);
				a.SetTimeScale(ts);
			}
        }
			
           
    }
	public function update(dt:Float):Void
	{
		
		 
	}
	public function render(batch:SpriteBatch):Void
	{
		
		
		
		if (graphic != null)
		{
		
		
		var viewx:Float = scene.room.viewport_x;
		var viewy:Float = scene.room.viewport_y;
			
		var px:Float = x;
		var py:Float = y;
		
		if (parent != null)
		{
		//traslate 
		px = this.x + parent.x;
		py = this.y + parent.y;
		
	
		
            var x_in:Float = px;
			var y_in:Float = py;
			
			
				    var a:Float =  -parent.angle * Math.PI / 180;
					var sin_a:Float = Math.sin(a);
				    var cos_a:Float = Math.cos(a);
		            px = ((x_in * cos_a) - (y_in * sin_a) + ( parent.x * (1 - cos_a)) + ( parent.y * sin_a) + (parent.centerx * parent.xscale) - centerx);
                    py = ((x_in * sin_a) + (y_in * cos_a) + ( parent.y * (1 - cos_a)) - ( parent.x * sin_a) + (parent.centery * parent.yscale) - centery);
		}
	
		
		batch.drawTextureEx(graphic.texture,
		px-viewx,py-viewy,
		this.graphic.width, this.graphic.height,
		this.xscale, this.yscale,
		this.angle,
		this.centerx, this.centery,
		this.graphic.getFrame(),
		this.flipx, this.flipy,
		red, green, blue, alpha, blend);
		
	

		}
	}
	
	public function debug(batch:BatchPrimitives):Void
	{
	  if (!showBound) return;
		
	if (graphic != null)
		{
		 var    nx, ny,
		tsx, tsy, tfx, tfy, tst,
		// circle:
		tcx, tcy, tcr,
		// bbox:
		tbl, tbr, tbt, tbb:Float = 0;
		
		
		    var viewx:Float = scene.room.viewport_x;
		    var viewy:Float = scene.room.viewport_y;
	
		var px:Float = x;
		var py:Float = y;
	
		
        if (parent != null)
		{
		
		px = x + parent.x ;
		py = y + parent.y ;
		
			
		//rotate
	
		
            var x_in:Float = px;
			var y_in:Float = py;
		    var a:Float =  -parent.angle * Math.PI / 180;
			var sin_a:Float = Math.sin(a);
		    var cos_a:Float = Math.cos(a);
		            px = ((x_in * cos_a) - (y_in * sin_a) + ( parent.x * (1 - cos_a)) + ( parent.y * sin_a) + (parent.centerx * parent.xscale) - centerx);
                    py = ((x_in * sin_a) + (y_in * cos_a) + ( parent.y * (1 - cos_a)) - ( parent.x * sin_a) + (parent.centery * parent.yscale) - centery);
		
		}
	
	
		
		 
    tfx = this.graphic.xoffset;
	tfy = this.graphic.yoffset;
	tsx = this.xscale;
	tsy = this.yscale;
	tst = this.graphic.collision_shape;
	

    
	// bbox:
    if (tst == 2) 
    {
		
		tbl = px + tsx * (bound.collision_left + tfx);
		tbr = px + tsx * (bound.collision_right + tfx);
		tbt = py + tsy * (bound.collision_top + tfy);
		tbb = py + tsy * (bound.collision_bottom + tfy);

		
		batch.rectangle(tbl-viewx , tbt-viewy , tbr-viewx , tbb-viewy , 1, 0, 0, 1);
		
	}
	// circle:
    if (tst == 3) 
    {
		tcr = this.graphic.collision_radius * (tsx > tsy ? tsx : tsy);
		tcx = px + tsx * (this.graphic.width / 2 + tfx);
		tcy = py + tsy * (this.graphic.height / 2 + tfy);
		batch.circle(tcx-viewx, tcy-viewy, tcr, 16, 1, 0, 0, 1);
    }  
		
		}
		
		
	}
	
	
	public function getRealPoint(point:Point):Point
	{
		

		    var _px:Float =x + point.x;
	  	    var _py:Float =y + point.y;
	        var x_in:Float = _px;
			var y_in:Float = _py;
		    var a:Float =  -angle * Math.PI / 180;
			var sin_a:Float = Math.sin(a);
		    var cos_a:Float = Math.cos(a);
		    _px = ((x_in * cos_a) - (y_in * sin_a) + ( x * (1 - cos_a)) + ( y * sin_a) + (centerx * xscale));
            _py = ((x_in * sin_a) + (y_in * cos_a) + ( y * (1 - cos_a)) - ( x * sin_a) + (centery * yscale));
		
		
		
		
		return new Point(_px,_py);
	}
	
	public function outScreen():Bool
	{
		
			
	if (graphic == null)
	{
		return false;
	}
		
		
		var 
		// sprite, scale:
		tsx, tsy, tfx, tfy, tst,
	
	
		// bbox:
		tbl, tbr, tbt, tbb:Float=0;
	
		
		
        var px:Float = this.x-scene.room.viewport_x ;
		var py:Float = this.y-scene.room.viewport_y ;
	
		
        if (parent != null)
		{
		
		 px = this.x + parent.x-scene.room.viewport_x ;
		 py = this.y + parent.y-scene.room.viewport_y ;
			
		}
	
	tfx = graphic.xoffset;
	tfy = graphic.yoffset;
	tsx = xscale;
	tsy = yscale;

	
	// bbox:
	
		tbl = px + tsx * (bound.collision_left + tfx);
		tbr = px + tsx * (bound.collision_right + tfx);
		tbt = py + tsy * (bound.collision_top + tfy);
		tbb = py + tsy * (bound.collision_bottom + tfy);
		
		//return !collide_bbox_bbox(tbl, tbt, tbr, tbb, 0, 0,scene.room.viewport_width, scene.room.viewport_height);
		//return !collide_bbox_bbox(tbl, tbt, tbr, tbb, 0, 0,Game.game.viewWidth, Game.game.viewHeight);
		return !collide_bbox_bbox(tbl, tbt, tbr, tbb, 0, 0,Game.game.screenWidth, Game.game.screenHeight);
		
        //return !collide_bbox_bbox(tbl, tbt, tbr, tbb, scene.room.viewport_x, scene.room.viewport_y, scene.room.viewport_x+640,scene.room.viewport_y+ 480);// scene.room.viewport_width, scene.room.viewport_height);
	
		
}
	
	
	public var scene(get, never):Scene;
	private inline function get_scene():Scene
	{
		room = _scene.room;
		return _scene;
	}
	
	public var type(get, set):String;
	private inline function get_type():String { return _type; }
	private function set_type(value:String):String
	{
		if (_type == value) return _type;
		if (_scene == null)
		{
			_type = value;
			return _type;
		}
		if (_type != "") _scene.removeType(this);
		_type = value;
		if (value != "") _scene.addType(this);
		return _type;
	}
	public var layer(get, set):Int;
	private inline function get_layer():Int { return _layer; }
	private function set_layer(value:Int):Int
	{
		if (_layer == value) return _layer;
		if (_scene == null)
		{
			_layer = value;
			return _layer;
		}
		_scene.removeRender(this);
		_layer = value;
		_scene.addRender(this);
		return _layer;
	}
	
	public var name(get, set):String;
	private inline function get_name():String { return _name; }
	private function set_name(value:String):String
	{
		if (_name == value) return _name;
		if (_scene == null)
		{
			_name = value;
			return _name;
		}
		if (_name != "") _scene.unregisterName(this);
		_name = value;
		if (value != "") _scene.registerName(this);
		return _name;
	}
	
	public var WorldX(get, never):Float;
	private inline function get_WorldX():Float 
	{
		
		if (parent != null)
		{
			return x + parent.x;
		} else
		{
		return x; 
		}
		
		}
	
	public var WorldY(get, never):Float;
	private inline function get_WorldY():Float 
	{
		if (parent != null)
		{
			return y + parent.y;
		} else
		{
		return y; 
		}
		
		
		}
	
	public function toString():String
	{
		return _class;
	}
	
	
	public function instance_position(x:Float, y:Float, type:String):Actor
	{
		
		
		var _px:Float = x;
		var _py:Float = y;
	
		
        if (parent != null)
		{
		
		_px = x + parent.x ;
		_py = y + parent.y ;
		
			
		//rotate
	
		
            var x_in:Float = _px;
			var y_in:Float = _py;
		    var a:Float =  -parent.angle * Math.PI / 180;
			var sin_a:Float = Math.sin(a);
		    var cos_a:Float = Math.cos(a);
		            _px = ((x_in * cos_a) - (y_in * sin_a) + ( parent.x * (1 - cos_a)) + ( parent.y * sin_a) + (parent.centerx * parent.xscale)-centerx);
                    _py = ((x_in * sin_a) + (y_in * cos_a) + ( parent.y * (1 - cos_a)) - ( parent.x * sin_a) + (parent.centery * parent.yscale)-centery);
		
		}
		
		
	var _x, _y, _ox, _oy, _sx, _sy,  _s,  _r, _dx, _dy:Float;
	var _i, _il:Int;
	if (_scene == null) return null;

	
		var entities = _scene.entitiesForType(type);
		if (!collidable || entities == null) return null;
		if (outScreen()) return null;
		
		

		
          
	        for (_o in entities)
			{
		
				if (_o.outScreen()) continue;
					_x = _o.x; 
					_sx = _o.xscale;
		            _y = _o.y; 
					_sy = _o.yscale;
					
				if (_o.graphic.collision_shape == 2)
				{
					
					if (_sx == 1 && _sy == 1) 
					{
			     	_ox = _o.graphic.xoffset; 
					_oy = _o.graphic.yoffset;
				    if (!collide_bbox_point(_x + _o.graphic.collision_left - _ox, _y + _o.graphic.collision_top - _oy, _x + _o.graphic.collision_right - _ox, _y + _o.graphic.collision_bottom - _oy, _px, _py)) continue;
					
					} else 
					{
				     if (!collide_sbox_point(_x, _y, _sx, _sy, _o.graphic, 0,0)) continue;
					}
				   
	                   return _o;
					
				} else
				if (_o.graphic.collision_shape == 3)
				{
		
					_r = _o.graphic.collision_radius * Math.max(_o.xscale, _o.yscale);
			        _dx = _o.x + (_o.graphic.width / 2 - _o.graphic.xoffset) - _px;
			        _dy = _o.y + (_o.graphic.height / 2 - _o.graphic.yoffset) - _py;
			        if ((_dx * _dx) + (_dy * _dy) > _r * _r) continue;
			        return _o;
			
				}
		
			
			}
			
			return null;

         }
		 
		 
public function place_meeting(x:Float, y:Float, type:String):Actor
	{
	
		var nx:Float = x;
		var ny:Float = y;
	
		
        if (parent != null)
		{
		
		nx = x + parent.x ;
		ny = y + parent.y ;
		
			
		//rotate
	
		
            var x_in:Float = nx;
			var y_in:Float = ny;
		    var a:Float =  -parent.angle * Math.PI / 180;
			var sin_a:Float = Math.sin(a);
		    var cos_a:Float = Math.cos(a);
		            nx = ((x_in * cos_a) - (y_in * sin_a) + ( parent.x * (1 - cos_a)) + ( parent.y * sin_a) + (parent.centerx * parent.xscale)-centerx);
                    ny = ((x_in * sin_a) + (y_in * cos_a) + ( parent.y * (1 - cos_a)) - ( parent.x * sin_a) + (parent.centery * parent.yscale)-centery);
		
		}
		
		
		// circle:
		var tcx:Int = 0;
			var tcy:Int = 0;
				var tcr:Int = 0;
		
		
		// bbox:
		var tbl:Int = 0;
		var tbr:Int = 0;
		var tbt:Int = 0;
		var tbb:Int = 0;
		
		
		// instances, multiple, output, types:
		var tz, tm, ct, ch, ra,
		// other:
		 ox, oy, os, ost, osx, osy, ofx, ofy, ofr=0 ;
		 
		var ts:Sprite = this.graphic;
		
  	    if (_scene == null) return null;
	    var entities = _scene.entitiesForType(type);
		if (!collidable || entities == null) return null;
		if (outScreen()) return null;
		
		
	var tfx:Float = ts.xoffset;
	var tfy:Float = ts.yoffset;
	var tsx:Float = xscale;
	var tsy:Float = yscale;
	var tst:Int = ts.collision_shape;

	// bbox:
	if (tst == 2) 
	{
		tbl = Std.int( nx + tsx * (ts.collision_left - tfx));
		tbr =Std.int( nx + tsx * (ts.collision_right - tfx));
		tbt =Std.int( ny + tsy * (ts.collision_top - tfy));
		tbb =Std.int( ny + tsy * (ts.collision_bottom - tfy));
	}
	// circle:
	if (tst == 3) {
		tcr =Std.int( ts.collision_radius * (tsx > tsy ? tsx : tsy));
		tcx =Std.int( nx + tsx * (ts.width / 2 - tfx));
		tcy =Std.int( ny + tsy * (ts.height / 2 - tfy));
	}
	
		
          
	        for (o in entities)
			{
		
				
				if (!o.collidable) continue;
				if (o.outScreen()) continue;
				
				os = o.graphic;
				if (os == null) continue;
					
		ox = o.x; osx = o.xscale;
		oy = o.y; osy = o.yscale;
		ost = os.collision_shape;
		ct = (tst << 4) | ost;
		ch = false;
			
		
		switch(ct) 
		{
		case 0x22:
			{
			if (osx == 1 && osy == 1)
			{
				ofx = os.xoffset; 
				ofy = os.yoffset;
				if (!collide_bbox_bbox(tbl, tbt, tbr, tbb,
				ox + os.collision_left - ofx, oy + os.collision_top - ofy,
				ox + os.collision_right - ofx, oy + os.collision_bottom - ofy)) continue;
			} else if (!collide_bbox_sbox(tbl, tbt, tbr, tbb, ox, oy, osx, osy, os)) continue;
			ch = true;
			}
		case 0x23:
			{
			ofr =Std.int( os.collision_radius * (osx > osy ? osx : osy));
			ofx =Std.int( ox + osx * (os.width / 2 - os.xoffset));
			ofy =Std.int( oy + osy * (os.height / 2 - os.yoffset));
			if (!collide_bbox_circle(tbl, tbt, tbr, tbb, ofx, ofy, ofr)) continue;
			ch = true;
			}
		case 0x32:
			{
			if (osx == 1 && osy == 1) {
				ofx = os.xoffset; ofy = os.yoffset;
				if (!collide_bbox_circle(
				ox + os.collision_left - ofx, oy + os.collision_top - ofy,
				ox + os.collision_right - ofx, oy + os.collision_bottom - ofy,
				tcx, tcy, tcr)) continue;
			} else if (!collide_sbox_circle(ox, oy, osx, osy, os, tcx, tcy, tcr)) continue;
			ch = true;
			}
		case 0x33:
			{
			ofr =Std.int( os.collision_radius * (osx > osy ? osx : osy));
			ofx =Std.int( ox + osx * (os.width / 2 - os.xoffset));
			ofy =Std.int( oy + osy * (os.height / 2 - os.yoffset));
			if (!collide_circle_circle(tcx, tcy, tcr, ofx, ofy, ofr)) continue;
			ch = true;
			}
			
		} 
		
		if (ch)
		{
			return o;
		}
		
			}
			
			return null;

         }
		 
	public function centerImage():Void
	{
		if (this.graphic != null)
		{
  		 this.centerx = this.graphic.getFrame().width / 2;
		 this.centery = this.graphic.getFrame().height / 2;
		}	
	}
		 
	public function mouse_meeting(x:Float, y:Float):Bool
   {

	var 
		// sprite, scale:
		tsx, tsy, tfx, tfy, tst,
		// circle:
		tcx, tcy, tcr,
		// bbox:
		tbl, tbr, tbt, tbb,
		// instances, multiple, output, types:
		tz, tm, ct, ch, ra,
		// other:
		o, ox, oy, os, ost, osx, osy, ofx, ofy, ofr;
		
		
		
        var px:Float = x;
		var py:Float = y;
	
		
        if (parent != null)
		{
		
		px = x + parent.x ;
		py = y + parent.y ;
		
			
		//rotate
	
		
            var x_in:Float = px;
			var y_in:Float = py;
		    var a:Float =  -parent.angle * Math.PI / 180;
			var sin_a:Float = Math.sin(a);
		    var cos_a:Float = Math.cos(a);
		            px = ((x_in * cos_a) - (y_in * sin_a) + ( parent.x * (1 - cos_a)) + ( parent.y * sin_a) + (parent.centerx * parent.xscale)-centerx);
                    py = ((x_in * sin_a) + (y_in * cos_a) + ( parent.y * (1 - cos_a)) - ( parent.x * sin_a) + (parent.centery * parent.yscale)-centery);
		
		}
		
	
	tfx = graphic.xoffset;
	tfy = graphic.yoffset;
	tsx = xscale;
	tsy = yscale;
	tst = graphic.collision_shape;
	
	// bbox:
	if (tst == 2) 
    {
		tbl = px + tsx * (bound.collision_left + tfx);
		tbr = px + tsx * (bound.collision_right + tfx);
		tbt = py + tsy * (bound.collision_top + tfy);
		tbb = py + tsy * (bound.collision_bottom + tfy);
        return collide_bbox_point(tbl, tbt, tbr, tbb,Game.game.mouse_x,Game.game.mouse_y);
	}
	// circle:
	if (tst == 3) 
    {
		tcr = graphic.collision_radius * (tsx > tsy ? tsx : tsy);
		tcx = px + tsx * (graphic.width / 2 + tfx);
		tcy = py + tsy * (graphic.height / 2 + tfy);
        return collide_circle_point(tcx,tcy,tcr,Game.game.mouse_x ,Game.game.mouse_y);
	}
    return false;
}
	
public function advance(speed:Float,dt:Float):Void
{
	var angle:Float = direction * d2r;
	this.x += speed * Math.cos(angle) *dt;
	this.y += speed * Math.sin(angle) *dt;
}
public  function  move_towards_point(_x:Float, _y:Float, _speed:Float):Void
	{
	if (_speed == 0) return;
	if (this.x == _x && this.y == _y) return;
	
	var _dx = _x - this.x;
	var	_dy = _y - this.y;
		
	var _dist = _dx * _dx + _dy * _dy;
		
	if (_dist < _speed * _speed) 
	{
		this.x = _x;
		this.y = _y;
	} else {
		_dist = Math.sqrt(_dist);
		this.x += _dx * _speed / _dist;
		this.y += _dy * _speed / _dist;
	}
	
}

//*************** ACTIONS
public var paused:Bool;
public var running:Bool;
public var numActions:Int;
private var actions:List<ActionInstant>;
private var actionsToDelete:List<ActionInstant>;
private var actionsToAdd:List<ActionInstant>;

	
	private var _recycleNext:Actor;
	private var _class:String;
	private var _scene:Scene;
	private var _type:String;
	private var _layer:Int;
	private var _name:String;
}