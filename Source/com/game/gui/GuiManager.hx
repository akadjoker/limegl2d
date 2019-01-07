package com.game.gui;
import com.game.gui.Uicontrol;
import com.engine.render.BatchPrimitives;
import com.engine.render.SpriteBatch;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class GuiManager
{
	public var guis:List<Uicontrol>;

	public function new() 
	{
		guis = new List<Uicontrol>();
	}
	public function add(g:Uicontrol):Void
	{
		guis.add(g);
	}
	public function remove(g:Uicontrol):Void
	{
		guis.remove(g);
		
	}
	public  function update(dt:Float)
	{
	  for (gui in guis)
	  {
		  gui.update(dt);
	  }
	}
	public function debug(canvas:BatchPrimitives):Void
	{
		for (gui in guis)
	  {
		  gui.debug(canvas);
	  }
	}
	public function render(batch:SpriteBatch):Void
	{
		for (gui in guis)
	  {
		  gui.render(batch);
	  }
	}
	public function mouseMove(mousex:Int, mousey:Int) 
	{ 
		for (gui in guis)
	  {
		  gui.mouseMove(mousex, mousey);
	  }
	}
	public function mouseUp(mousex:Int, mousey:Int) 
	{ 
		for (gui in guis)
	    {
			gui.mouseUp(mousex, mousey);
	    }
		
	}
	public function mouseDown(mousex:Int, mousey:Int) 
	{
		for (gui in guis)
	    {
			gui.mouseDown(mousex, mousey);
	    }
	}
	public function resize(w:Int, h:Int):Void
	{
		
		for (gui in guis)
	    {
			gui.resize(w, h);
	    }
	}

}