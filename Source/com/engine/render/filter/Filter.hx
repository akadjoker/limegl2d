package com.engine.render.filter;

/**
 * ...
 * @author djoker
 */
class Filter
{




		   
		

		
	


static public var twistFilter =
 #if !desktop
"precision mediump float;" +
#end
  " 
        varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform vec4 dimensions;
        uniform sampler2D uImage0;

        uniform float radius;
        uniform float angle;
        uniform vec2 offset;

        void main(void) {
           vec2 coord = vTexCoord - offset;
           float distance = length(coord);

           if (distance < radius) {
               float ratio = (radius - distance) / radius;
               float angleMod = ratio * ratio * angle;
               float s = sin(angleMod);
               float c = cos(angleMod);
               coord = vec2(coord.x * c - coord.y * s, coord.x * s + coord.y * c);
           }

           gl_FragColor = texture2D(uImage0, coord+offset);
        }";		
		


		
	   
static public var dotscreenFilter =
 #if !desktop
"precision mediump float;" +
#end
  " 
        varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform sampler2D uImage0;
        uniform float angle;
        uniform float scale;
		

        float pattern() 
		{
		   vec4 dimensions = vec4(0,0,0,0);
           float s = sin(angle), c = cos(angle);
           vec2 tex = vTexCoord * dimensions.xy;
           vec2 point = vec2(
               c * tex.x - s * tex.y,
               s * tex.x + c * tex.y
           ) * scale;
           return (sin(point.x) * sin(point.y)) * 4.0;
        }

        void main() {
           vec4 color = texture2D(uImage0, vTexCoord);
           float average = (color.r + color.g + color.b) / 3.0;
           gl_FragColor = vec4(vec3(average * 10.0 - 5.0 + pattern()), color.a);
        }";
		

static public var rgbsplitFilter =
 #if !desktop
"precision mediump float;" +
#end
  " 
        varying vec2 vTexCoord;
        varying vec4 vColor;
		uniform float distance;
        uniform vec2 red;
        uniform vec2 green;
        uniform vec2 blue;
        uniform vec4 dimensions;
        uniform sampler2D uImage0;

        void main(void) 
		{
           gl_FragColor.r = texture2D(uImage0, vTexCoord + red/distance).r;
           gl_FragColor.g = texture2D(uImage0, vTexCoord + green/distance).g;
           gl_FragColor.b = texture2D(uImage0, vTexCoord + blue/distance).b;
           gl_FragColor.a = texture2D(uImage0, vTexCoord).a;
        }";
		
static public var croshatchFilter =
 #if !desktop
"precision mediump float;" +
#end
  " 		
        varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform float blur;
        uniform sampler2D uImage0;

        void main(void) {
            float lum = length(texture2D(uImage0, vTexCoord.xy).rgb);

            gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);

            if (lum < 1.00) {
                if (mod(gl_FragCoord.x + gl_FragCoord.y, 10.0) == 0.0) {
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
                }
            }

            if (lum < 0.75) {
                if (mod(gl_FragCoord.x - gl_FragCoord.y, 10.0) == 0.0) {
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
                }
            }
            if (lum < 0.50) {
                if (mod(gl_FragCoord.x + gl_FragCoord.y - 5.0, 10.0) == 0.0) {
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
                }
           }

            if (lum < 0.3) {
                if (mod(gl_FragCoord.x - gl_FragCoord.y - 5.0, 10.0) == 0.0) {
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
                }
            }
        }";
		
static public var colormatrixFilter =
 #if !desktop
"precision mediump float;" +
#end
  " 
        varying vec2 vTexCoord;
        varying vec4 vColor;
        uniform mat4 matrix;
        uniform sampler2D uImage0;

        void main(void) {
           gl_FragColor = texture2D(uImage0, vTexCoord) * matrix;
        }";
    		
}