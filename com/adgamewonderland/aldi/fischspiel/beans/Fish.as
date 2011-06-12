import mx.utils.Iterator;

import com.adgamewonderland.aldi.fischspiel.behaviours.EatBehaviour;
import com.adgamewonderland.aldi.fischspiel.behaviours.IEatBehaviour;
import com.adgamewonderland.aldi.fischspiel.behaviours.IMoveBehaviour;
import com.adgamewonderland.aldi.fischspiel.behaviours.MoveBehaviour;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.interfaces.IEatable;
import com.adgamewonderland.aldi.fischspiel.interfaces.IMovable;

import flash.geom.Matrix;
import flash.geom.Point;

class com.adgamewonderland.aldi.fischspiel.beans.Fish implements IEatable, IMovable
{

	public static var NUMSIZES:Number = 5;

	private static var MOVEINTERVAL:Number = 1000 / 50;

	private static var COLLISIONRADIUS:Number = 20;

	private var id:Number;

	private var size:Number;

	private var lives:Number;

	private var position:Point;

	private var direction:Matrix;

	private var moveBehaviour:IMoveBehaviour;

	private var eatBehaviour:IEatBehaviour;

	private var interval:Number;

	private function Fish()
	{
		// id
		this.id = -1;
		// size
		this.size = -1;
		// lives
		this.lives = 1;
		// position
		this.position = new Point(0, 0);
		// richtungsmatrix
		this.direction = new Matrix();
		// bewegung regelmassig updaten
		this.interval = setInterval(this, "doMove", MOVEINTERVAL);
		// bewegungsverhalten
		this.moveBehaviour = new MoveBehaviour();
		// fressverhalten
		this.eatBehaviour = new EatBehaviour();
	}

	public function doUnload():Void
	{
		clearInterval(this.interval);
	}

	public function doMove():Void
	{
		// bewegen
		this.moveBehaviour.moveMe(this);
		// kollisionen checken
		checkCollisions();
	}

	public function doEat(aObj:IEatable):Void
	{
		// auffressen
		var result:Number = this.eatBehaviour.eat(this, aObj);
		// je nach ergebnis
		switch (result) {
			case 1 :
				// controller erledigt alles weitere
				TankController.getInstance().eatFish(this, Fish(aObj));

				break;
			case -1 :

				break;
			case 0 :

				break;
		}
	}

	public function updatePosition(aPos:Point):Void
	{
		// neue richtung
		this.direction.tx = aPos.x - this.position.x;
		this.direction.ty = aPos.y - this.position.y;
		// neue position
		this.position = aPos;
	}

	public function getPosition():Point
	{
		return this.position;
	}

	public function getDirection():Matrix
	{
		return this.direction;
	}

	public function equals(aFish:Fish ):Boolean
	{
		return aFish.getId() == this.getId();
	}

	public function setId(aId:Number):Void
	{
		this.id = aId;
	}

	public function getId():Number
	{
		return this.id;
	}

	public function setSize(aSize:Number):Void
	{
		this.size = aSize;
	}

	public function getSize():Number
	{
		return this.size;
	}

	public function setLives(aLives:Number):Void
	{
		this.lives = aLives;
	}

	public function getLives():Number
	{
		return this.lives;
	}

	public function setMoveBehaviour(aMoveBehaviour:IMoveBehaviour):Void
	{
		this.moveBehaviour = aMoveBehaviour;
	}

	public function setEatBehaviour(aEatBehaviour:IEatBehaviour):Void
	{
		this.eatBehaviour = aEatBehaviour;
	}

	public function toString() : String {
		return "com.adgamewonderland.aldi.fischspiel.beans.Fish: " + getId();
	}

	private function checkCollisions():Void
	{
		// gegner
		var opponent:Fish;
		// iterator ueber alle fische
		var iterator:Iterator = TankController.getInstance().getFishes().getIterator();
		// schleife
		while (iterator.hasNext()) {
			// gegner
			opponent = Fish(iterator.next());
			// sich selbst ueberspringen
			if (opponent.equals(this))
				continue;
			// abstand unterschritten
			if (Point.distance(getPosition(), opponent.getPosition()) < getSize() * COLLISIONRADIUS) {
				// auffressen
				doEat(opponent);
			}
		}
	}

}
