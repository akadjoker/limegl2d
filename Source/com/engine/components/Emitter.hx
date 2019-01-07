package com.engine.components;


import com.engine.misc.Clip;
import com.engine.misc.Color3;
import com.engine.misc.Util;
import com.engine.render.SpriteBatch;
import com.engine.render.Texture;
import com.geom.Matrix;
import com.geom.Point;

using com.engine.components.PexParticles;
/**
 * ...
 * @author djoekr
 */
class Emitter 

{
	
	public var clip:Clip;
	public var blendMode:Int;
	public var angle:Float;

	  /** The particle texture, must be square. */
    public var texture :Texture;

    /** The current number of particles being shown. */
    public var numParticles (default, null) :Int = 0;

    public var maxParticles (get, set) :Int;

    public var emtype :EmitterType;

    /** How long the emitter should remain enabled, or <= 0 to never expire. */
    public var duration :Float;

    /** Whether new particles are being actively emitted. */
    public var enabled :Bool = true;

    public var emitX (default, null) :Float;
    public var emitXVariance (default, null) :Float;

    public var emitY (default, null) :Float;
    public var emitYVariance (default, null) :Float;

    public var alphaStart (default, null) :Float;
    public var alphaStartVariance (default, null) :Float;

    public var alphaEnd (default, null) :Float;
    public var alphaEndVariance (default, null) :Float;

 //   public var angle (default, null) :Float;
    public var angleVariance (default, null) :Float;

    public var gravityX (default, null) :Float;
    public var gravityY (default, null) :Float;

    public var maxRadius (default, null) :Float;
    public var maxRadiusVariance (default, null) :Float;

    public var minRadius (default, null) :Float;

    public var lifespanVariance (default, null) :Float;
    public var lifespan (default, null) :Float;

    public var rotatePerSecond (default, null) :Float;
    public var rotatePerSecondVariance (default, null) :Float;

    public var rotationStart (default, null) :Float;
    public var rotationStartVariance (default, null) :Float;

    public var rotationEnd (default, null) :Float;
    public var rotationEndVariance (default, null) :Float;

    public var sizeStart (default, null) :Float;
    public var sizeStartVariance (default, null) :Float;

    public var sizeEnd (default, null) :Float;
    public var sizeEndVariance (default, null) :Float;

    public var speed (default, null) :Float;
    public var speedVariance (default, null) :Float;

    public var radialAccel (default, null) :Float;
    public var radialAccelVariance (default, null) :Float;

    public var tangentialAccel (default, null) :Float;
    public var tangentialAccelVariance (default, null) :Float;
	
	public var startColor:Color3 = new Color3();
	public var endColor:Color3 = new Color3();
	
	public var startColorVar:Color3 = new Color3();
	public var endColorVar:Color3 = new Color3();
	
//	public var blendMode :BlendMode;
		

    public function new (mold :PexParticles,?tex_clip:Clip=null)
    {
     clip = new Clip();
		

        texture = mold.texture;
        blendMode = mold.blendMode;
        emtype = mold.type;
		
		if (tex_clip != null)
		{
			clip = tex_clip;
		} else
		{
			clip.set(0, 0, texture.width, texture.height);
		}
		
		//clip.set(0, 0, texture.width, texture.height);

		startColor.set(mold.rStart, mold.gStart, mold.bStart);
		endColor.set(mold.rEnd, mold.bEnd, mold.gEnd);
		startColorVar.set(mold.rStartVariance, mold.gStartVariance, mold.bStartVariance);
		endColorVar.set(mold.rEndVariance, mold.gEndVariance, mold.bEndVariance);
		
		
		
        alphaEnd =mold.alphaEnd;
        alphaEndVariance =mold.alphaEndVariance;
        alphaStart =mold.alphaStart;
        alphaStartVariance =mold.alphaStartVariance;
        angle =mold.angle;
        angleVariance =mold.angleVariance;
        duration = mold.duration;
        emitXVariance =mold.emitXVariance;
        emitYVariance =mold.emitYVariance;
        gravityX =mold.gravityX;
        gravityY =mold.gravityY;
        maxRadius =mold.maxRadius;
        maxRadiusVariance =mold.maxRadiusVariance;
        minRadius =mold.minRadius;
        lifespan =mold.lifespan;
        lifespanVariance =mold.lifespanVariance;
        radialAccel =mold.radialAccel;
        radialAccelVariance =mold.radialAccelVariance;
        rotatePerSecond =mold.rotatePerSecond;
        rotatePerSecondVariance =mold.rotatePerSecondVariance;
        rotationEnd =mold.rotationEnd;
        rotationEndVariance =mold.rotationEndVariance;
        rotationStart =mold.rotationStart;
        rotationStartVariance =mold.rotationStartVariance;
        sizeEnd =mold.sizeEnd;
        sizeEndVariance =mold.sizeEndVariance;
        sizeStart =mold.sizeStart;
        sizeStartVariance =mold.sizeStartVariance;
        speed =mold.speed;
        speedVariance =mold.speedVariance;
        tangentialAccel =mold.tangentialAccel;
        tangentialAccelVariance =mold.tangentialAccelVariance;

        emitX = 0;
        emitY = 0;

        _particles = new Array<Particle>() ; //Arrays.create(mold.maxParticles);
        var ii = 0, ll = mold.maxParticles;// _particles.length;
		
		
			
        while (ii < ll) 
		{
			
            _particles[ii] = new Particle();
            ++ii;
        }
		

    }

    public function restart ()
    {
        enabled = true;
        _totalElapsed = 0;
    }

	 public function renderEx(m:Matrix,batch:SpriteBatch)
	{

		    var alpha:Float;
            var rotation:Float;
            var x:Float; 
			var y:Float;
            var xOffset:Float;
			var yOffset:Float;
			var color:Color3;
			
	

        var ii:Int = 0;
		var ll:Int = numParticles;
		

for (i in 0...numParticles)
{
	 var particle = _particles[i];
	 
	            color = particle.color;
                alpha = particle.alpha;
                rotation = particle.rotation;
	
				
			var px:Float = particle.x;
			var py:Float = particle.y;
			x = m.a * px + -m.c * py + m.tx;
		    y = m.d * py + m.b * px + m.ty;
			
				
             
                xOffset = ( clip.width /2    * particle.scale );
                yOffset = ( clip.height / 2  * particle.scale );
				
				if (alpha <= 0) continue;
								
		
				
		
					
				batch.drawVertex(texture,
                x - xOffset, y - yOffset,
                x - xOffset, y + yOffset,
                x + xOffset, y + yOffset,
                x + xOffset, y - yOffset,
				clip, color.r,color.g,color.b, alpha, blendMode);
			
			
			
}



	}
	 public function render(localx:Float,localy:Float,batch:SpriteBatch)
	{

		    var alpha:Float;
            var rotation:Float;
			var color:Color3;
		    var xOffset:Float =  clip.width  / 2;
            var yOffset:Float =  clip.height / 2;
	

        var ii:Int = 0;
		var ll:Int = numParticles;
		
		          var xOffset:Float =  clip.width  / 2;
            var yOffset:Float =  clip.height / 2;
		

for (i in 0...numParticles)
{
	 var particle = _particles[i];
	 
	            color = particle.color;
                alpha = particle.alpha;
                rotation = particle.rotation;
	
				
			var dstx:Float = particle.x+localx;
			var dsty:Float = particle.y+localy;
			
				
                   var  TX1 = -xOffset * particle.scale;
                   var  TY1 = -yOffset * particle.scale;
                   var  TX2 = (clip.width  - xOffset) * particle.scale;
                   var  TY2 = (clip.height - yOffset) * particle.scale;
				
				if (alpha <= 0) continue;
				
				
				       if (rotation!=0)
                {
       
                   var CosT:Float  = Math.cos(rotation);
                   var SinT:Float  = Math.sin(rotation);
                 	
      batch.drawVertex(texture,
 TX1 * CosT - TY1 * SinT + dstx,TX1 * SinT + TY1 * CosT + dsty,
 TX2 * CosT - TY1 * SinT + dstx,TX2 * SinT + TY1 * CosT + dsty,
 TX2 * CosT - TY2 * SinT + dstx,TX2 * SinT + TY2 * CosT + dsty,
 TX1 * CosT - TY2 * SinT + dstx,TX1 * SinT + TY2 * CosT + dsty,
 clip,  color.r, color.g, color.b, alpha, blendMode);
				   

				   
                }
                else 
                {
				
		
				batch.drawVertex(texture,
                TX1 + dstx, TY1 + dsty,
                TX2 + dstx, TY1 + dsty,
                TX2 + dstx, TY2 + dsty,
                TX1 + dstx, TY2 + dsty,
				clip,  color.r, color.g, color.b,alpha, blendMode);
				

	
				}
				
			
			
			
}



	}
	 public function update(dt:Float)
	{
	  
    
	

        // Update existing particles
        var gravityType = (emtype == Gravity);
        var ii = 0;
        while (ii < numParticles) 
		{
            var particle = _particles[ii];
            if (particle.life > dt) 
			{
                if (gravityType) 
				{
                    particle.x += particle.velX * dt;
                    particle.y += particle.velY * dt;

                    var accelX = gravityX;
                    var accelY = -gravityY;

                    if (particle.radialAccel != 0 || particle.tangentialAccel != 0)
					{
                        var dx = particle.x - particle.emitX;
                        var dy = particle.y - particle.emitY;
                        var distance = Math.sqrt(dx*dx + dy*dy);

                        // Apply radial force
                        var radialX = dx / distance;
                        var radialY = dy / distance;
                        accelX += radialX * particle.radialAccel;
                        accelY += radialY * particle.radialAccel;

                        // Apply tangential force
                        var tangentialX = -radialY;
                        var tangentialY = radialX;
                        accelX += tangentialX * particle.tangentialAccel;
                        accelY += tangentialY * particle.tangentialAccel;
                    }

                    particle.velX += accelX * dt;
                    particle.velY += accelY * dt;

                } else {
                    particle.radialRotation += particle.velRadialRotation * dt;
                    particle.radialRadius += particle.velRadialRadius * dt;

                    var radius = particle.radialRadius;
                    particle.x = emitX - Math.cos(particle.radialRotation) * radius;
                    particle.y = emitY - Math.sin(particle.radialRotation) * radius;

                    if (radius < minRadius) 
					{
                        particle.life = 0; // Kill it
                    }
                }

                particle.scale += particle.velScale * dt;
                particle.rotation += particle.velRotation * dt;
                particle.alpha += particle.velAlpha * dt;
				particle.color.r += particle.velColor.r * dt;
				particle.color.g += particle.velColor.g * dt;
				particle.color.b += particle.velColor.b * dt;
				

                particle.life -= dt;
                ++ii;

            } else {
                // Kill it, and swap it with the last living particle, so that alive particles are
                // packed to the front of the pool
                --numParticles;
                if (ii != numParticles) 
				{
                    _particles[ii] = _particles[numParticles];
                    _particles[numParticles] = particle;
                }
            }
        }

        // Check whether we should continue to the emit step
        if (!enabled) 
		{
            return;
        }
		
        if (duration > 0)
		{
            _totalElapsed += dt;
            if (_totalElapsed >= duration) 
			{
                enabled = false;
                return;
            }
        }

        // Emit new particles
        var emitDelay = lifespan / _particles.length;
        _emitElapsed += dt;
        while (_emitElapsed >= emitDelay)
		{
            if (numParticles < _particles.length) 
			{
                var particle = _particles[numParticles];
                if (initParticle(particle)) 
				{
                    ++numParticles;
                }
            }
            _emitElapsed -= emitDelay;
        }
		
    }

 

    private function initParticle (particle :Particle) :Bool
    {
        particle.life = random(lifespan, lifespanVariance);
        if (particle.life <= 0) {
            return false; // Dead on arrival
        }

        // Don't include the variance here
        particle.emitX = emitX;
        particle.emitY = emitY;

        var angle = -Util.toRadians(random(angle, angleVariance));
        var speed = random(speed, speedVariance);
        particle.velX = speed * Math.cos(angle);
        particle.velY = speed * Math.sin(angle);

        particle.radialAccel = random(radialAccel, radialAccelVariance);
        particle.tangentialAccel = random(tangentialAccel, tangentialAccelVariance);

        particle.radialRadius = random(maxRadius, maxRadiusVariance);
        particle.velRadialRadius = -particle.radialRadius / particle.life;
        particle.radialRotation = angle;
        particle.velRadialRotation = Util.toRadians(random(rotatePerSecond, rotatePerSecondVariance));

        if (emtype == Gravity) {
            particle.x = random(emitX, emitXVariance);
            particle.y = random(emitY, emitYVariance);

        } else { // type == Radial
            var radius = particle.radialRadius;
            particle.x = emitX - Math.cos(particle.radialRotation) * radius;
            particle.y = emitY - Math.sin(particle.radialRotation) * radius;
        }

        // Assumes that the texture is always square
        var width = texture.width;
        var scaleStart = random(sizeStart, sizeStartVariance) / width;
        var scaleEnd = random(sizeEnd, sizeEndVariance) / width;
        particle.scale = scaleStart;
        particle.velScale = (scaleEnd-scaleStart) / particle.life;

        var rotationStart = random(rotationStart, rotationStartVariance);
        var rotationEnd = random(rotationEnd, rotationEndVariance);
        particle.rotation = rotationStart;
        particle.velRotation = (rotationEnd-rotationStart) / particle.life;

		

	
	  var rStart = random(startColor.r, startColorVar.r);
	  var rEnd   = random(endColor.r, endColorVar.r);
	  particle.color.r = rStart;
	  particle.velColor.r = (rEnd - rStart) / particle.life;
	  
	  var gStart = random(startColor.g, startColorVar.g);
	  var gEnd   = random(endColor.g, endColorVar.g);
	  particle.color.g = gStart;
	  particle.velColor.g = (gEnd - gStart) / particle.life;
	
	  var bStart = random(startColor.b, startColorVar.b);
	  var bEnd   = random(endColor.b, endColorVar.b);
	  particle.color.b = bStart;
	  particle.velColor.b = (bEnd - bStart) / particle.life;
	
	
		
        var alphaStart = random(alphaStart, alphaStartVariance);
        var alphaEnd = random(alphaEnd, alphaEndVariance);
        particle.alpha = alphaStart;
        particle.velAlpha = (alphaEnd-alphaStart) / particle.life;

		
		
        return true;
    }

    inline private function get_maxParticles () :Int
    {
        return _particles.length;
    }

    private function set_maxParticles (maxParticles :Int) :Int
    {
        // Grow the pool
        var oldLength = _particles.length;
       // _particles.resize(maxParticles);
        while (oldLength < maxParticles) 
		{
            _particles[oldLength] = new Particle();
            ++oldLength;
        }

        if (numParticles > maxParticles) {
            numParticles = maxParticles;
        }

        return maxParticles;
    }

    private static function random (base :Float, variance :Float)
    {
        if (variance != 0) {
            base += variance * (2*Math.random()-1);
        }
        return base;
    }

    // The particle pool
    private var _particles :Array<Particle>;

    // Time passed since the last emission
    private var _emitElapsed :Float = 0;

    private var _totalElapsed :Float = 0;
}

private class Particle
{
    // Where the emitter was when the particle was spawned
    public var emitX :Float = 0;
    public var emitY :Float = 0;

    public var x :Float = 0;
    public var velX :Float = 0;

    public var y :Float = 0;
    public var velY :Float = 0;

    public var radialRadius :Float = 0;
    public var velRadialRadius :Float = 0;

    public var radialRotation :Float = 0;
    public var velRadialRotation :Float = 0;

    public var radialAccel :Float = 0;
    public var tangentialAccel :Float = 0;

    public var scale :Float = 0;
    public var velScale :Float = 0;

    public var rotation :Float = 0;
    public var velRotation :Float = 0;

    public var alpha :Float = 0;
    public var velAlpha :Float = 0;

    public var life :Float = 0;
	
	public var color:Color3;
	public var velColor:Color3;

    public function new () 
	{
		
			color = new Color3();
			velColor= new Color3();
		}
}
