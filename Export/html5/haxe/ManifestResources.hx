package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Dynamic):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		
		#end
		
		var data, manifest, library;
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		data = '{"name":null,"assets":"aoy4:pathy13:gfx%2F04f.pngy4:sizei6198y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y24:gfx%2Falagard-bmfont.pngR2i4420R3R4R5R7R6tgoR0y15:gfx%2Farial.pngR2i10466R3R4R5R8R6tgoR0y15:gfx%2Fblock.pngR2i985R3R4R5R9R6tgoR0y21:gfx%2FdefaultSkin.pngR2i1649R3R4R5R10R6tgoR0y14:gfx%2Ffire.pngR2i722R3R4R5R11R6tgoR0y16:gfx%2Fhxlogo.pngR2i16900R3R4R5R12R6tgoR0y16:gfx%2Fpirate.pngR2i12619R3R4R5R13R6tgoR0y30:gfx%2Fround_font-pixelizer.pngR2i1201R3R4R5R14R6tgoR0y19:gfx%2Fspaz_font.pngR2i12049R3R4R5R15R6tgoR0y17:gfx%2Fsprites.pngR2i54410R3R4R5R16R6tgoR0y15:gfx%2Fstars.jpgR2i184817R3R4R5R17R6tgoR0y17:gfx%2Fterrain.pngR2i49272R3R4R5R18R6tgoR0y17:gfx%2Ftexture.pngR2i668R3R4R5R19R6tgoR0y15:gfx%2Ftiles.pngR2i4296R3R4R5R20R6tgoR0y18:gfx%2Ftinyfont.pngR2i16702R3R4R5R21R6tgoR0y22:gfx%2Fwabbit_alpha.pngR2i449R3R4R5R22R6tgoR0y14:gfx%2Fwood.jpgR2i32309R3R4R5R23R6tgoR0y15:gfx%2Fworld.pngR2i626437R3R4R5R24R6tgoR0y19:gfx%2Fxfilesfnt.pngR2i10694R3R4R5R25R6tgoR0y16:gfx%2Fzazaka.pngR2i5179R3R4R5R26R6tgoR0y15:atlas%2F04b.fntR2i11060R3y4:TEXTR5R27R6tgoR0y26:atlas%2Falagard-bmfont.fntR2i11504R3R28R5R29R6tgoR0y19:atlas%2Fexahust.pexR2i1448R3R28R5R30R6tgoR0y19:atlas%2Fexplode.pexR2i1979R3R28R5R31R6tgoR0y21:atlas%2Fexplosion.pexR2i1411R3R28R5R32R6tgoR0y15:atlas%2Fmap.tmxR2i1697R3R28R5R33R6tgoR0y15:atlas%2Fmap.txtR2i1339R3R28R5R34R6tgoR0y18:atlas%2Fmapxml.tmxR2i11865R3R28R5R35R6tgoR0y19:atlas%2Fsprites.xmlR2i9743R3R28R5R36R6tgoR0y20:atlas%2Ftinyfont.xmlR2i22499R3R28R5R37R6tgoR0y17:atlas%2FTorch.pexR2i1397R3R28R5R38R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__gfx_04f_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_alagard_bmfont_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_arial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_defaultskin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_fire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_hxlogo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_pirate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_round_font_pixelizer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_spaz_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_sprites_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_stars_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_terrain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_texture_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_tinyfont_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_wabbit_alpha_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_wood_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_world_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_xfilesfnt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_zazaka_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__atlas_04b_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_alagard_bmfont_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_exahust_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_explode_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_explosion_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_map_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_map_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_mapxml_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_sprites_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_tinyfont_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__atlas_torch_pex extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("assets/graphics/04f.png") #if display private #end class __ASSET__gfx_04f_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/alagard-bmfont.png") #if display private #end class __ASSET__gfx_alagard_bmfont_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/arial.png") #if display private #end class __ASSET__gfx_arial_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/block.png") #if display private #end class __ASSET__gfx_block_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/defaultSkin.png") #if display private #end class __ASSET__gfx_defaultskin_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/fire.png") #if display private #end class __ASSET__gfx_fire_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/hxlogo.png") #if display private #end class __ASSET__gfx_hxlogo_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/pirate.png") #if display private #end class __ASSET__gfx_pirate_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/round_font-pixelizer.png") #if display private #end class __ASSET__gfx_round_font_pixelizer_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/spaz_font.png") #if display private #end class __ASSET__gfx_spaz_font_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/sprites.png") #if display private #end class __ASSET__gfx_sprites_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/stars.jpg") #if display private #end class __ASSET__gfx_stars_jpg extends lime.graphics.Image {}
@:keep @:image("assets/graphics/terrain.png") #if display private #end class __ASSET__gfx_terrain_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/texture.png") #if display private #end class __ASSET__gfx_texture_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/tiles.png") #if display private #end class __ASSET__gfx_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/tinyfont.png") #if display private #end class __ASSET__gfx_tinyfont_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/wabbit_alpha.png") #if display private #end class __ASSET__gfx_wabbit_alpha_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/wood.jpg") #if display private #end class __ASSET__gfx_wood_jpg extends lime.graphics.Image {}
@:keep @:image("assets/graphics/world.png") #if display private #end class __ASSET__gfx_world_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/xfilesfnt.png") #if display private #end class __ASSET__gfx_xfilesfnt_png extends lime.graphics.Image {}
@:keep @:image("assets/graphics/zazaka.png") #if display private #end class __ASSET__gfx_zazaka_png extends lime.graphics.Image {}
@:keep @:file("assets/atlas/04b.fnt") #if display private #end class __ASSET__atlas_04b_fnt extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/alagard-bmfont.fnt") #if display private #end class __ASSET__atlas_alagard_bmfont_fnt extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/exahust.pex") #if display private #end class __ASSET__atlas_exahust_pex extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/explode.pex") #if display private #end class __ASSET__atlas_explode_pex extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/explosion.pex") #if display private #end class __ASSET__atlas_explosion_pex extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/map.tmx") #if display private #end class __ASSET__atlas_map_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/map.txt") #if display private #end class __ASSET__atlas_map_txt extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/mapxml.tmx") #if display private #end class __ASSET__atlas_mapxml_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/sprites.xml") #if display private #end class __ASSET__atlas_sprites_xml extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/tinyfont.xml") #if display private #end class __ASSET__atlas_tinyfont_xml extends haxe.io.Bytes {}
@:keep @:file("assets/atlas/Torch.pex") #if display private #end class __ASSET__atlas_torch_pex extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end