class de.kruesch.skijumping.JumpState
{
	static var IDLE:JumpState = new JumpState("IDLE");
	static var ACCELERATE:JumpState = new JumpState("ACCELERATE");
	static var PREPARE:JumpState = new JumpState("PREPARE");
	static var JUMP:JumpState = new JumpState("JUMP");
	static var LANDED:JumpState = new JumpState("LANDED");
	static var FINISHED:JumpState = new JumpState("FINISHED");
	
	 // verstecke c'tor 
	private function JumpState(n:String) { _name = n; }
	
	private var _name:String;	
	public function toString() 
	{
		return "[JumpState:"+_name+"]";
	}
}
