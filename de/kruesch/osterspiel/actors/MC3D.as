// Basisklasse für alle 3D positionierbaren MCs
class de.kruesch.osterspiel.actors.MC3D extends MovieClip
{
	var x:Number;
	var y:Number;

	function update() : Void
	{
		this._x = x;
		this._y = y;

		var yn = 500-y;

		this._xscale = this._yscale = 90000/yn;
		this._x = 325 + 300 * x/yn;		
		this._y = -10 + 250000/yn;

		this._visible = y<0;
		if (_visible) this.swapDepths(int(30000-yn));
	}
}