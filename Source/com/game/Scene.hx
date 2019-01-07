package com.game;
import com.game.gui.GuiManager;
import com.engine.misc.BlendMode;
import com.engine.misc.Util;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;
import com.engine.render.Texture;
import com.game.gui.Uicontrol;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Scene extends Api
{

	
	public var guiManager:GuiManager;
// Adding and removal.
	private var _add:Array<Actor>;
	private var _remove:Array<Actor>;
	private var _recycle:Array<Actor>;

	// Update information.
	private var _update:List<Actor>;

	// Render information.
	private var _layerList:Array<Int>;
	private var _layerDisplay:Map<Int,Bool>;
	private var _layers:Map<Int,List<Actor>>;

	private var _classCount:Map<String,Int>;

	private var _types:Map<String,List<Actor>>;

	private var _recycled:Map<String,Actor>;
	private var _entityNames:Map<String,Actor>;
	

	
    public var numRender:Int;
	public var id:String;
	public var room:Room;
	public function new(_id:String) 
	{
		super();
		id = _id;
	
		numRender = 0;
		_layerList = new Array<Int>();

		_add = new Array<Actor>();
		_remove = new Array<Actor>();
		_recycle = new Array<Actor>();

		_update = new List<Actor>();
		_layerDisplay = new Map<Int,Bool>();
		_layers = new Map<Int,List<Actor>>();
		_types = new Map<String,List<Actor>>();

		_classCount = new Map<String,Int>();
		_recycled = new Map<String,Actor>();
		_entityNames = new Map<String,Actor>();
	
	    guiManager = new GuiManager();
	}
	
	public function start():Void
	{
		
	}
	public function end():Void
	{
		
	}
	public function update(dt:Float):Void
	{
		
		for (e in _update)
		{
			
			if (!e.active) 
			{
				remove(e);
				continue;
			}
			
			if (!e.sleep)
			{
				if (e.onUpdate != null)
				{
					e.onUpdate();
				}
				e.updateActions(dt);
				e.update(dt);
				e.LateUpdate();
			}
			
		}
		
		guiManager.update(dt);
	}
	
	public function setFolow(obj:Actor):Void
	{
		this.room.viewport_object = obj;
	}
	public function updateLists(shouldAdd:Bool = true)
	{
		var e:Actor;

		// remove entities
		if (_remove.length > 0)
		{
			for (e in _remove)
			{
				if (e._scene == null)
				{
					var idx = Util.indexOf(_add, e);
					if (idx >= 0) _add.splice(idx, 1);
					continue;
				}
				if (e._scene != this)
					continue;
					
				if (e.onEnd != null)
				{
					e.onEnd();
				}
				
				e.end();
				e._scene = null;
				e.room = null;
				removeUpdate(e);
				removeRender(e);
				if (e._type != "") removeType(e);
				if (e._name != "") unregisterName(e);
				
			}
			Util.clear(_remove);
		}

		// add entities
		if (shouldAdd && _add.length > 0)
		{
			for (e in _add)
			{
				if (e._scene != null) continue;
				e._scene = this;
				e.room = room;
				addUpdate(e);
				addRender(e);
				if (e._type != "") addType(e);
				if (e._name != "") registerName(e);
				if (e.onBegin != null)
				{
					e.onBegin();
				}
				e.start();
			}
			Util.clear(_add);
		}

		// recycle entities
		if (_recycle.length > 0)
		{
			for (e in _recycle)
			{
				if (e._scene != null || e._recycleNext != null)
					continue;

				e._recycleNext = _recycled.get(e._class);
				_recycled.set(e._class, e);
			}
			Util.clear(_recycle);
		}
	}
	
	public function render(batch:SpriteBatch):Void
	{
		numRender = 0;
		
		
		for (layer in _layerList)
		{
			if (!layerVisible(layer)) continue;
			for (e in _layers.get(layer))
			{
			if (e != null)	
			{
				if (e.visible && !e.outScreen()) 
				{
			
					 e.render(batch); 
					 numRender++; 
					
					
				}
			}
			}
		}
		
	guiManager.render(batch);
	}
	
	public function debug(batch:BatchPrimitives):Void
	{
		for (layer in _layerList)
		{
			if (!layerVisible(layer)) continue;
			for (e in _layers.get(layer))
			{
			if(e!=null)	if (e.visible) e.debug(batch);
			}
		}
		guiManager.debug(batch);
	}

	
	public inline function entitiesForType(type:String):List<Actor>
	{
		return _types.exists(type) ? _types.get(type) : null;
	}

	public inline function showLayer(layer:Int, show:Bool=true):Void
	{
		_layerDisplay.set(layer, show);
	}
private function addUpdate(e:Actor)
	{
		// add to update list
		_update.add(e);
		if (_classCount.get(e._class) != 0) _classCount.set(e._class, 0);
		_classCount.set(e._class, _classCount.get(e._class) + 1); // increment
	}


	private function removeUpdate(e:Actor)
	{
		_update.remove(e);
		_classCount.set(e._class, _classCount.get(e._class) - 1); // decrement
	}

	public inline function layerVisible(layer:Int):Bool
	{
		return !_layerDisplay.exists(layer) || _layerDisplay.get(layer);
	}

    public function add<E:Actor>(e:E):E
	{
		_add[_add.length] = e;
		return e;
	}


	public function remove<E:Actor>(e:E):E
	{
		_remove[_remove.length] = e;
		return e;
	}

 public function addGui(e:Uicontrol):Uicontrol
	{
		guiManager.add(e);
		return e;
	}


	public function removeGui(e:Uicontrol):Uicontrol
	{
		guiManager.remove(e);
		return e;
	}

	public function removeAll()
	{
		for (e in _update)
		{
			_remove[_remove.length] = e;
		}
	}

	public function addList<E:Actor>(list:Iterable<E>)
	{
		for (e in list) add(e);
	}
	public function removeList<E:Actor>(list:Iterable<E>)
	{
		for (e in list) remove(e);
	}
	public function recycle<E:Actor>(e:E):E
	{
		_recycle[_recycle.length] = e;
		return remove(e);
	}

@:allow(com.game.Actor)
	private function addType(e:Actor)
	{
		var list:List<Actor>;
		// add to type list
		if (_types.exists(e._type))
		{
			list = _types.get(e._type);
		}
		else
		{
			list = new List<Actor>();
			_types.set(e._type, list);
		}
		list.push(e);
	}

	/** @private Removes Entity from the type list. */
	@:allow(com.game.Actor)
	private function removeType(e:Actor)
	{
		if (!_types.exists(e._type)) return;
		var list = _types.get(e._type);
		list.remove(e);
		if (list.length == 0)
		{
			_types.remove(e._type);
		}
	}

	/** @private Register the entities instance name. */
	@:allow(com.game.Actor)
	private inline function registerName(e:Actor)
	{
		_entityNames.set(e._name, e);
	}

	/** @private Unregister the entities instance name. */
	@:allow(com.game.Actor)
	private inline function unregisterName(e:Actor):Void
	{
		_entityNames.remove(e._name);
	}
	public function clearRecycled<E:Actor>(classType:Class<E>)
	{
		var className:String = Type.getClassName(classType),
			e:Actor = _recycled.get(className),
			n:Actor;
		while (e != null)
		{
			n = e._recycleNext;
			e._recycleNext = null;
			e = n;
		}
		_recycled.remove(className);
	}

	@:allow(com.game.Actor)
	private function addRender(e:Actor)
	{
		var list:List<Actor>;
		if (_layers.exists(e._layer))
		{
			list = _layers.get(e._layer);
		}
		else
		{
			// Create new layer with entity.
			list = new List<Actor>();
			_layers.set(e._layer, list);

			if (_layerList.length == 0)
			{
				_layerList[0] = e._layer;
			}
			else
			{
			Util .insertSortedKey(_layerList, e._layer, layerSort);
			}
		}
		list.add(e);
	}

	public function getInstance(name:String):Actor
	{
		return _entityNames.get(name);
	}
	public var count(get, never):Int;
	private inline function get_count():Int { return _update.length; }
	private function layerSort(a:Int, b:Int):Int
	{
		return b - a;
	}
	public function getType<E:Actor>(type:String, into:Array<E>)
	{
		if (!_types.exists(type)) return;
		var n:Int = into.length;
		for (e in _types.get(type))
		{
			into[n++] = cast e;
		}
	}
		public function getClass<T, E:Actor>(c:Class<T>, into:Array<E>)
	{
		var n:Int = into.length;
		for (e in _update)
		{
			if (Std.is(e, c))
				into[n++] = cast e;
		}
	}
	
	public function getLayer<E:Actor>(layer:Int, into:Array<E>)
	{
		var n:Int = into.length;
		for (e in _layers.get(layer))
		{
			into[n ++] = cast e;
		}
	}
    public function getAll<E:Actor>(into:Array<E>)
	{
		var n:Int = into.length;
		for (e in _update)
		{
			into[n ++] = cast e;
		}
	}
	
	@:allow(com.game.Actor)
	private function removeRender(e:Actor)
	{
		var list = _layers.get(e._layer);
		list.remove(e);
		if (list.length == 0)
		{
			_layerList.remove(e._layer);
			_layers.remove(e._layer);
		}
	}
 
	
	
		
	
	public function clearRecycledAll()
	{
		var e:Actor;
		for (e in _recycled)
		{
			clearRecycled(Type.getClass(e));
		}
	}

	public function mouseMove(mousex:Int, mousey:Int)
	{ guiManager.mouseMove(mousex, mousey);}
	public function mouseUp(mousex:Int, mousey:Int)
	{guiManager.mouseUp(mousex, mousey); }
	public function mouseDown(mousex:Int, mousey:Int)
	{guiManager.mouseDown(mousex, mousey); }

}