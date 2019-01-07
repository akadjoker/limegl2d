package com.engine;


import com.engine.input.Keys;
import com.engine.input.Touch;
import com.engine.misc.Util;
import com.engine.render.Texture;
import lime.app.Application;
import lime.graphics.RenderContext;
import lime.graphics.WebGLRenderContext;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.utils.Log;













/**
 * ...
 * @author djoker

 */
class Game extends Application {



public static var game:Game;
public static var gl:WebGLRenderContext;
public static var now:Int = 0;
public static var then:Int = 0;
public static var frameStart:Int = 0;
public static var fps:Int = 0;
public static var dt:Float = 0;
public static var frames:Int = 0;
public static var fixedTimestep:Bool = true;


public  var touchNum:Int = 0;
private  var _touches:Map<Int,Touch> = new Map<Int,Touch>();


public  var Touche:Map<Int,Touch> = new Map<Int,Touch>();

public  var multiTouchSupported:Bool;
public var mouse_x:Int=0;
public var mouse_y:Int=0;
public var mouse_down:Bool = false;
public var mouse_released:Bool = false;
public var mouse_pressed:Bool = false;
private var  key_down:Array<Bool>;
private var  key_pressed:Array<Bool>;
private var  key_released:Array<Bool>;
private var  keys_pressed:Array<Int>;
private var  keys_released:Array<Int>;

private var  vkeys:Array<Int>;




	
	private var ready:Bool;
	public var deltaTime:Float;
    private var prevFrame:Int;
    private var nextFrame:Int; 

	private var screen:Screen = null;

	//value from the windows resize
	public var screenWidth:Int = 0;
	public var screenHeight:Int = 0;



	
	private var rescale:Bool = false;
	private var enableDepth:Bool;
    public var red:Float;
    public var green:Float;
    public var blue:Float;
	private var textures:Map<String,com.engine.render.Texture>;
	private var requestedFramerate:Int;
	
		




	public function new()
	{
     super();
	Game.game = this;
 	ready = false;
 
	  key_down = [];
	  key_pressed = [];
      key_released = [];
	  keys_pressed = [];
      keys_released = [];

      vkeys= [];

	  requestedFramerate = 60;

	 for (i in 0...256)
	{
	key_down[i] = false;
	key_released[i] = false;
	key_pressed[i] = false;
	}


		
		
	
		textures= new  Map<String,Texture>();
	
		

	prevFrame = Util.getTime();
	
	

	
	}
	
	
	public function setDeph(v:Bool)
	{
		enableDepth = v;
		if (v == true)
		{
		 gl.disable(gl.DEPTH_TEST);
		} else
		{
		gl.enable(gl.DEPTH_TEST);
		gl.depthFunc(gl.FASTEST);
    	}
	}
	public function clarColor(r:Float, g:Float, b:Float)
	{
		red = r;
		green = g;
		blue = b;
	}

		
	
			
 
 public function Init(g:WebGLRenderContext,w:Int,h:Int) :Void
 {
	Game.gl = g;
	
		   //
    gl.disable(gl.CULL_FACE);
    gl.enable(gl.BLEND);
	gl.blendFunc(gl.SRC_ALPHA,gl.DST_ALPHA );
	gl.pixelStorei(gl.PACK_ALIGNMENT, 2);
    setDeph(true);
	clarColor(0, 0, 0.4);
	gl.clearColor(red, green, blue, 1);
	gl.depthMask(true);
	gl.colorMask(true, true, true, true);
	gl.activeTexture(gl.TEXTURE0);
	this.screenWidth = w;
	this.screenHeight = h;
	ready = true; 
    begin(); 
	}

	public override function onWindowResize (width:Int, height:Int):Void 
	{
		this.screenWidth = width;
	    this.screenHeight = height;
		resize(width, height);

	}
	
/*


	private function doTouchDown (e:TouchEvent):Void 
	{
		var touchPoint = new Touch(e.stageX , e.stageY , e.touchPointID);
		touchPoint.update();
		_touches.set(e.touchPointID, touchPoint);
		touchNum += 1;
		if (screen != null) screen.mouseDown(e.stageX, e.stageY);
	
		//trace(touchPoint.id + " ," +touchPoint.x + ", " +touchPoint.y);
	}
	private function doTouchUp (e:TouchEvent):Void 
	{
		_touches.remove(e.touchPointID);
		touchNum -= 1;
		if (screen != null) screen.mouseUp(e.stageX, e.stageY);
	}
    private function doTouchMove (e:TouchEvent):Void 
	{
		var point = _touches.get(e.touchPointID);
		point.update();
		point.x = e.stageX ;
		point.y = e.stageY ;
        if (screen != null) screen.mouseMove(e.stageX, e.stageY);
	}


	*/
	public function begin() {  }
	public function end()   {  }
	public function resize(width:Int, height:Int) 
	{
        screenWidth  = width;
		screenHeight = height;
		
		
		


		if (screen != null) screen.resize(width, height);
	}
	public function Update(dt:Float) 
	{
	if (screen != null) screen.update(dt);	
	
	}
	

	
    public function keyDown(key:Int) { };
	public function keyUp(key:Int) { };

	public function mouseMove(mousex:Float, mousey:Float) { };
	public function mouseUp(mousex:Float, mousey:Float) { };
	public function mouseDown(mousex:Float, mousey:Float) { };
	
	public function setScreen ( screen:Screen) 
	{
		if (this.screen != null) this.screen.dispose();
		this.screen = screen;
		this.screen.game = this;
		if (this.screen != null)
		{
			this.screen.width  = screenWidth;
			this.screen.height = screenHeight;
			this.screen.show();
			this.screen.resize(screenWidth, screenHeight);
			
		}
	}
	
	

		
public function renderView(context:RenderContext):Void 
{ 
	

	
	
	
    var timer:Int = getTimer();


	
   
	nextFrame = Util.getTime();
    deltaTime = (nextFrame - prevFrame) * 0.001;
    gl.clearColor(red, green, blue, 1);
	
	if (enableDepth == true)
	{
	 gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	} else
	{
	gl.clear(gl.COLOR_BUFFER_BIT );	
	}

 
	if (ready)
	{
	
	 	if (screen != null) screen.render();

    }
	

 gl.bindBuffer (gl.ARRAY_BUFFER, null);	
 gl.useProgram (null);	
 gl.blendFunc(gl.SRC_ALPHA, gl.DST_ALPHA );
 

 
//

timer = getTimer();
prevFrame = nextFrame;
}
	
public function getTexture(url:String, ?flip:Bool = false ):Texture 
{
	if (textures.exists(url))
	{
		return textures.get(url);
	} else
	{	
	var tex = new Texture();
	tex.load(url, flip);
	textures.set(url,tex);
	return tex;
	}
}
private  function updateTimer()
{
then = now;
now = getTimer();
dt = then == 0 ? 0 : (now - then) / 1000;
if (fixedTimestep) {
dt = 1 / requestedFramerate;
}
Update(dt);
frames++;
if (now - frameStart >= 1000) 
{
	fps = Std.int(Math.min(requestedFramerate, frames));
frames = 0;
frameStart = now;
}
}

public  function getTimer():Int
{
	return Util.getTime();
}


public  function touchPoints(touchCallback:Touch->Void)
	{
		for (touch in _touches)
		{
			touchCallback(touch);
		}
	}
public  var touches(get, never):Map<Int,Touch>;
private  inline function get_touches():Map<Int,Touch> { return _touches; }
	
public function keyboard_check(_key:Int):Bool { return key_down[_key]; }
public function keyboard_check_pressed(_key:Int):Bool { return key_pressed[_key]; }
public function keyboard_check_released(_key:Int):Bool { return key_released[_key]; }

public function mouse_check():Bool 
{ 

	 return mouse_down; 	

	
	
}
public function mouse_check_pressed():Bool { return mouse_pressed; }
public function mouse_check_released():Bool { return mouse_released; }


   public override function onKeyDown (key:KeyCode, modifier:KeyModifier):Void 
   {
	
	  var keycode:Int = convertKeyCode(key);
 
	  if (!key_down[keycode])
	  {
		  key_pressed[keycode] = true;
		  keys_pressed.push(keycode);
	  }
	  key_down[keycode] = true;
		keyDown(keycode);
		if (screen != null) screen.keyDown(keycode);

		
	}
   public override function onKeyUp (key:KeyCode, modifier:KeyModifier):Void 
   {
	   var keycode:Int = convertKeyCode(key);
	 if (key_down[keycode])
	  {
		  key_released[keycode] = true;
		  keys_released.push(keycode);
	  }
	  key_down[keycode] = false;
	  keyUp(keycode);
		if (screen != null) screen.keyUp(keycode);
	   
   }
   
	public override function onMouseDown (x:Float, y:Float, button:Int):Void {

	if (!mouse_down) mouse_pressed = true;
	mouse_down = true;
	mouse_x =Std.int( x);
	mouse_y =Std.int( y);
	mouseDown(x,y);
	if (screen != null) screen.mouseDown(x,y);
	}
	
	
	public override function onMouseUp (x:Float, y:Float, button:Int):Void 
	{
    if (mouse_down) mouse_released = true;
	mouse_down = false;
	mouseUp(x,y);
	if (screen != null) screen.mouseUp(x,y);
		
		
	}
	
	public override function onMouseMove (x:Float, y:Float):Void 
	{
    	
			mouse_x =Std.int( x);
		mouse_y =Std.int( y);
		
	mouseMove(x,y);
	if (screen != null) screen.mouseMove(x,y);
		
	}
	
	
	public override function onPreloadComplete ():Void {
		
	
		switch (window.context.type) {
			
			case OPENGL, OPENGLES, WEBGL:
               Init(window.context.webgl,window.width,window.height);
			default:
				
				Log.warn ("Current render context not supported by this sample");
			
		}
		
		
		
	}
	
	
	public override function render (context:RenderContext):Void {
		
		if (!preloader.complete) return;

		 renderView(window.context);
		
	}
	
	
	public override function update (deltaTime:Int):Void
	{
		if (!preloader.complete) return;
	
		updateTimer();
		
		 for (k in 0...keys_pressed.length)
	{
		key_pressed[keys_pressed[k]] = false;
	}
	for (k in 0... keys_released.length)
	{
		key_released[keys_released[k]] = false;
	}
	keys_pressed = [];
	keys_released = [];
	mouse_pressed = false;
	mouse_released = false;
	}
	private function convertKeyCode (keyCode:KeyCode):Int

	{

		

		return switch (keyCode) {

			

			case BACKSPACE: Keys.BACKSPACE;

			case TAB: Keys.TAB;

			case RETURN: Keys.ENTER;

			case ESCAPE: Keys.ESCAPE;

			case SPACE: Keys.SPACE;

			//case EXCLAMATION: 0x21;

			//case QUOTE: 0x22;

			//case HASH: 0x23;

			//case DOLLAR: 0x24;

			//case PERCENT: 0x25;

			//case AMPERSAND: 0x26;

			case SINGLE_QUOTE: Keys.QUOTE;

			//case LEFT_PARENTHESIS: 0x28;

			//case RIGHT_PARENTHESIS: 0x29;

			//case ASTERISK: 0x2A;

			//case PLUS: 0x2B;

			case COMMA: Keys.COMMA;

			case MINUS: Keys.MINUS;

			case PERIOD: Keys.PERIOD;

			case SLASH: Keys.SLASH;

			case NUMBER_0: Keys.NUMBER_0;

			case NUMBER_1: Keys.NUMBER_1;

			case NUMBER_2: Keys.NUMBER_2;

			case NUMBER_3: Keys.NUMBER_3;

			case NUMBER_4: Keys.NUMBER_4;

			case NUMBER_5: Keys.NUMBER_5;

			case NUMBER_6: Keys.NUMBER_6;

			case NUMBER_7: Keys.NUMBER_7;

			case NUMBER_8: Keys.NUMBER_8;

			case NUMBER_9: Keys.NUMBER_9;

			//case COLON: 0x3A;

			case SEMICOLON: Keys.SEMICOLON;

			//case LESS_THAN: 0x3C;

			case EQUALS: Keys.EQUAL;

			//case GREATER_THAN: 0x3E;

			//case QUESTION: 0x3F;

			//case AT: 0x40;

			case LEFT_BRACKET: Keys.LEFTBRACKET;

			case BACKSLASH: Keys.BACKSLASH;

			case RIGHT_BRACKET: Keys.RIGHTBRACKET;

			//case CARET: 0x5E;

			//case UNDERSCORE: 0x5F;

			case GRAVE: Keys.BACKQUOTE;

			case A: Keys.A;

			case B: Keys.B;

			case C: Keys.C;

			case D: Keys.D;

			case E: Keys.E;

			case F: Keys.F;

			case G: Keys.G;

			case H: Keys.H;

			case I: Keys.I;

			case J: Keys.J;

			case K: Keys.K;

			case L: Keys.L;

			case M: Keys.M;

			case N: Keys.N;

			case O: Keys.O;

			case P: Keys.P;

			case Q: Keys.Q;

			case R: Keys.R;

			case S: Keys.S;

			case T: Keys.T;

			case U: Keys.U;

			case V: Keys.V;

			case W: Keys.W;

			case X: Keys.X;

			case Y: Keys.Y;

			case Z: Keys.Z;

			case DELETE: Keys.DELETE;

			case CAPS_LOCK: Keys.CAPS_LOCK;

			case F1: Keys.F1;

			case F2: Keys.F2;

			case F3: Keys.F3;

			case F4: Keys.F4;

			case F5: Keys.F5;

			case F6: Keys.F6;

			case F7: Keys.F7;

			case F8: Keys.F8;

			case F9: Keys.F9;

			case F10: Keys.F10;

			case F11: Keys.F11;

			case F12: Keys.F12;

			//case PRINT_SCREEN: 0x40000046;

			//case SCROLL_LOCK: 0x40000047;

			//case PAUSE: 0x40000048;

			case INSERT: Keys.INSERT;

			case HOME: Keys.HOME;

			case PAGE_UP: Keys.PAGE_UP;

			case END: Keys.END;

			case PAGE_DOWN: Keys.PAGE_DOWN;

			case RIGHT: Keys.RIGHT;

			case LEFT: Keys.LEFT;

			case DOWN: Keys.DOWN;

			case UP: Keys.UP;

			//case NUM_LOCK_CLEAR: 0x40000053;

			case NUMPAD_DIVIDE: Keys.NUMPAD_DIVIDE;

			case NUMPAD_MULTIPLY: Keys.NUMPAD_MULTIPLY;

			case NUMPAD_MINUS: Keys.NUMPAD_SUBTRACT;

			case NUMPAD_PLUS: Keys.NUMPAD_ADD;

			case NUMPAD_ENTER: Keys.NUMPAD_ENTER;

			case NUMPAD_1: Keys.NUMPAD_1;

			case NUMPAD_2: Keys.NUMPAD_2;

			case NUMPAD_3: Keys.NUMPAD_3;

			case NUMPAD_4: Keys.NUMPAD_4;

			case NUMPAD_5: Keys.NUMPAD_5;

			case NUMPAD_6: Keys.NUMPAD_6;

			case NUMPAD_7: Keys.NUMPAD_7;

			case NUMPAD_8: Keys.NUMPAD_8;

			case NUMPAD_9: Keys.NUMPAD_9;

			case NUMPAD_0: Keys.NUMPAD_0;

			case NUMPAD_PERIOD: Keys.NUMPAD_DECIMAL;

			//case APPLICATION: 0x40000065;

			//case POWER: 0x40000066;

			//case NUMPAD_EQUALS: 0x40000067;

			case F13: Keys.F13;

			case F14: Keys.F14;

			case F15: Keys.F15;

			//case F16: 0x4000006B;

			//case F17: 0x4000006C;

			//case F18: 0x4000006D;

			//case F19: 0x4000006E;

			//case F20: 0x4000006F;

			//case F21: 0x40000070;

			//case F22: 0x40000071;

			//case F23: 0x40000072;

			//case F24: 0x40000073;

			//case EXECUTE: 0x40000074;

			//case HELP: 0x40000075;

			//case MENU: 0x40000076;

			//case SELECT: 0x40000077;

			//case STOP: 0x40000078;

			//case AGAIN: 0x40000079;

			//case UNDO: 0x4000007A;

			//case CUT: 0x4000007B;

			//case COPY: 0x4000007C;

			//case PASTE: 0x4000007D;

			//case FIND: 0x4000007E;

			//case MUTE: 0x4000007F;

			//case VOLUME_UP: 0x40000080;

			//case VOLUME_DOWN: 0x40000081;

			//case NUMPAD_COMMA: 0x40000085;

			////case NUMPAD_EQUALS_AS400: 0x40000086;

			//case ALT_ERASE: 0x40000099;

			//case SYSTEM_REQUEST: 0x4000009A;

			//case CANCEL: 0x4000009B;

			//case CLEAR: 0x4000009C;

			//case PRIOR: 0x4000009D;

			//case RETURN2: 0x4000009E;

			//case SEPARATOR: 0x4000009F;

			//case OUT: 0x400000A0;

			//case OPER: 0x400000A1;

			//case CLEAR_AGAIN: 0x400000A2;

			//case CRSEL: 0x400000A3;

			//case EXSEL: 0x400000A4;

			//case NUMPAD_00: 0x400000B0;

			//case NUMPAD_000: 0x400000B1;

			//case THOUSAND_SEPARATOR: 0x400000B2;

			//case DECIMAL_SEPARATOR: 0x400000B3;

			//case CURRENCY_UNIT: 0x400000B4;

			//case CURRENCY_SUBUNIT: 0x400000B5;

			//case NUMPAD_LEFT_PARENTHESIS: 0x400000B6;

			//case NUMPAD_RIGHT_PARENTHESIS: 0x400000B7;

			//case NUMPAD_LEFT_BRACE: 0x400000B8;

			//case NUMPAD_RIGHT_BRACE: 0x400000B9;

			//case NUMPAD_TAB: 0x400000BA;

			//case NUMPAD_BACKSPACE: 0x400000BB;

			//case NUMPAD_A: 0x400000BC;

			//case NUMPAD_B: 0x400000BD;

			//case NUMPAD_C: 0x400000BE;

			//case NUMPAD_D: 0x400000BF;

			//case NUMPAD_E: 0x400000C0;

			//case NUMPAD_F: 0x400000C1;

			//case NUMPAD_XOR: 0x400000C2;

			//case NUMPAD_POWER: 0x400000C3;

			//case NUMPAD_PERCENT: 0x400000C4;

			//case NUMPAD_LESS_THAN: 0x400000C5;

			//case NUMPAD_GREATER_THAN: 0x400000C6;

			//case NUMPAD_AMPERSAND: 0x400000C7;

			//case NUMPAD_DOUBLE_AMPERSAND: 0x400000C8;

			//case NUMPAD_VERTICAL_BAR: 0x400000C9;

			//case NUMPAD_DOUBLE_VERTICAL_BAR: 0x400000CA;

			//case NUMPAD_COLON: 0x400000CB;

			//case NUMPAD_HASH: 0x400000CC;

			//case NUMPAD_SPACE: 0x400000CD;

			//case NUMPAD_AT: 0x400000CE;

			//case NUMPAD_EXCLAMATION: 0x400000CF;

			//case NUMPAD_MEM_STORE: 0x400000D0;

			//case NUMPAD_MEM_RECALL: 0x400000D1;

			//case NUMPAD_MEM_CLEAR: 0x400000D2;

			//case NUMPAD_MEM_ADD: 0x400000D3;

			//case NUMPAD_MEM_SUBTRACT: 0x400000D4;

			//case NUMPAD_MEM_MULTIPLY: 0x400000D5;

			//case NUMPAD_MEM_DIVIDE: 0x400000D6;

			//case NUMPAD_PLUS_MINUS: 0x400000D7;

			//case NUMPAD_CLEAR: 0x400000D8;

			//case NUMPAD_CLEAR_ENTRY: 0x400000D9;

			//case NUMPAD_BINARY: 0x400000DA;

			//case NUMPAD_OCTAL: 0x400000DB;

			//case NUMPAD_DECIMAL: 0x400000DC;

			//case NUMPAD_HEXADECIMAL: 0x400000DD;

			case LEFT_CTRL: Keys.CONTROL;

			case LEFT_SHIFT: Keys.SHIFT;

			case LEFT_ALT: Keys.ALTERNATE;

			//case LEFT_META: 0x400000E3;

			case RIGHT_CTRL: Keys.CONTROL;

			case RIGHT_SHIFT: Keys.SHIFT;

			case RIGHT_ALT: Keys.ALTERNATE;

			//case RIGHT_META: 0x400000E7;

			//case MODE: 0x40000101;

			//case AUDIO_NEXT: 0x40000102;

			//case AUDIO_PREVIOUS: 0x40000103;

			//case AUDIO_STOP: 0x40000104;

			//case AUDIO_PLAY: 0x40000105;

			//case AUDIO_MUTE: 0x40000106;

			//case MEDIA_SELECT: 0x40000107;

			//case WWW: 0x40000108;

			//case MAIL: 0x40000109;

			//case CALCULATOR: 0x4000010A;

			//case COMPUTER: 0x4000010B;

			//case APP_CONTROL_SEARCH: 0x4000010C;

			//case APP_CONTROL_HOME: 0x4000010D;

			//case APP_CONTROL_BACK: 0x4000010E;

			//case APP_CONTROL_FORWARD: 0x4000010F;

			//case APP_CONTROL_STOP: 0x40000110;

			//case APP_CONTROL_REFRESH: 0x40000111;

			//case APP_CONTROL_BOOKMARKS: 0x40000112;

			//case BRIGHTNESS_DOWN: 0x40000113;

			//case BRIGHTNESS_UP: 0x40000114;

			//case DISPLAY_SWITCH: 0x40000115;

			//case BACKLIGHT_TOGGLE: 0x40000116;

			//case BACKLIGHT_DOWN: 0x40000117;

			//case BACKLIGHT_UP: 0x40000118;

			//case EJECT: 0x40000119;

			//case SLEEP: 0x4000011A;

			default: cast keyCode;

			

		}

		

	}


}