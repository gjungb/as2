import de.kruesch.math.*;
import de.kruesch.osterspiel.actors.*;
import de.kruesch.osterspiel.logic.*;

class de.kruesch.osterspiel.actors.Enemy extends MC3D
{
	var r:Number;
	var knockedOut:Boolean;
	var ko:Boolean;

	var dir:Vector; // Direction
	var step:Vector; // Bewegungs Schritt

	var speed:Number;
	var typ:Number;
	private var rebirth:Number;

	private var field:Battlefield;
	
	private var randomframe:Number; // 02.05.2006 gj: erweiterung fuer gaffel bzgl. unterschiedlicher figuren

	function Enemy()
	{
		knockedOut = false;

		dir = new Vector(0,0);
		step = new Vector(0,0);

		r = 40;			// Gr�sse / Radius
		speed = 1.5;	// Geschwindigkeit
		rebirth = 1;	// Anzahl Wiedergeburten (Aufstehen)
		typ = 1;		// Gegner Typ
	}

	function moveTo(x:Number,y:Number) : Void
	{
		this.x = x;
		this.y = y;
	}

	function moveBy(v:Vector) : Void
	{
		this.x += v.x;
		this.y += v.y;
	}

	function moveStep() : Void
	{
		this.x += this.step.x;
		this.y += this.step.y;	
		
		if (this.dir.length()>0.01) 
		{
			this.dir = this.dir.multiply(0.9);
		} 
		else 
		{
			this.dir = new Vector(0,0);
		}		
	}

	function initMove() : Void
	{
		this.step = this.dir.clone();
	}

	function knockOut() : Void
	{
		this.knockedOut = true;
		this.gotoAndPlay("knockout");

		rebirth--;
	}

	function getBounding() : Circle
	{
		return new Circle(new Vector(this.x,this.y),r);
	}

	function getPos() : Vector
	{
		return new Vector(x,y);
	}

	function onKnockedOut() : Void
	{
		if (rebirth>0) 
		{
			this.gotoAndPlay("alive");
			this.knockedOut = false;
		} 
		else 
		{
			this.gotoAndPlay("kill");
			field.removeEnemy(this);
		}
	}

	function setBattlefield(b:Battlefield) : Void
	{
		field = b;
	}
	
	// 02.05.2006 gj: erweiterung fuer gaffel bzgl. unterschiedlicher figuren
	
	public function initRandomframe(mc:MovieClip ):Number
	{
		// anzahl frames
		var frames:Number = mc._totalframes;
		// zufaelliger frame
		setRandomframe(Math.ceil(Math.random() * frames));
		// zurueck geben
		return getRandomframe();
	}
	
	public function getRandomframe():Number {
		return randomframe;
	}

	public function setRandomframe(randomframe:Number):Void {
		this.randomframe = randomframe;
	}

}