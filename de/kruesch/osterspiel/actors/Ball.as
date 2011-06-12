import de.kruesch.math.*;
import de.kruesch.osterspiel.actors.*;

class de.kruesch.osterspiel.actors.Ball extends MC3D
{
	var x:Number;
	var y:Number;

	var r:Number;

	var dir:Vector;
	var moving:Boolean;

	function Ball()
	{
		x = 0;
		y = 0;

		moving = true;
		r = 30;
	}

	function getPos() : Vector
	{
		return new Vector(x,y);
	}

	function moveTo(x:Number,y:Number) : Void
	{
		this.x = x;
		this.y = y;
	}

	function bounce() : Void
	{
		this.gotoAndPlay("bounce");
	}

	function idle() : Void
	{
		this.gotoAndStop(1);
		this._visible = true;
	}
}

