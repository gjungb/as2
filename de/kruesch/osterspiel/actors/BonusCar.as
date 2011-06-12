import de.kruesch.osterspiel.actors.*;
import de.kruesch.math.*;

class de.kruesch.osterspiel.actors.BonusCar extends MC3D
{
	var dir:Number;
	var r:Number;
	private var innerMC;

	private static var ground:MovieClip;
	private static var LINKAGEID:String = "wagen";

	function BonusCar()
	{
		r = 60;
	}

	function getBounding() : Circle
	{
		return new Circle(new Vector(x,y),r);
	}

	function setDirection(sgn:Number) : Void
	{
		dir = sgn;
		innerMC._xscale = sgn*100;
	}

	static function setGround(g:MovieClip) : Void
	{
		ground = g;
	}

	static function create() : BonusCar
	{
		return BonusCar(ground.attachMovie(LINKAGEID,"bonus",1000));
	}
};
