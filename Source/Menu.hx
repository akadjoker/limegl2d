package;
import com.game.Scene;
import com.engine.render.SpriteBatch;
import com.engine.components.text.Text;
import lime.utils.Assets;

/**
 * ...
 * @author Luis Santos AKA DJOKER
 */
class Menu extends Scene
{
		var iFont:Text;
		var times:Array<Float>;

	public function new() 
	{
		super("Menu");
	}
	override public function start():Void 
	{
		 times = [];
		 
		trace("start menu");
		iFont = new Text("assets/tinyfont.fnt", "MENU");
	}
	override public function end():Void 
	{
		trace("end menu");
	}
    override public function render(batch:SpriteBatch):Void 
	{
		
			 var now = com.engine.misc.Util.getTime () / 1000;
      times.push(now);
      while(times[0]<now-1)
         times.shift();
		 iFont.text = "\nFPS:" + times.length + "/";
    
		 
		
		
		super.render(batch);
		iFont.print(batch, 640/2, 480/2);
	}
	override public function update(dt:Float):Void 
	{
	super.update(dt);
	}
	
}