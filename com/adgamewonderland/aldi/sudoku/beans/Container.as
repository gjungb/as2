/* 
 * Generated by ASDT 
*/ 



class com.adgamewonderland.aldi.sudoku.beans.Container {
	
	public static var TYPE_ROW:Number = 1;
	
	public static var TYPE_COLUMN:Number = 2;
	
	public static var TYPE_BOX:Number = 3;
	
	public static var TYPE_CONTENT:Number = 4;
	
	private var id:Number;
	
	private var type:Number;
	
	private var fields:Array;
	
	private var editable:Boolean;
	
	public function Container() {
		this.id = null;
		this.type = -1;
		this.fields = new Array();
		this.editable = true;
	}
	
	public function getFields():Array {
		return fields;
	}

	public function setFields(fields:Array):Void {
		this.fields = fields;
	}

	public function getEditable():Boolean {
		return editable;
	}

	public function setEditable(editable:Boolean):Void {
		this.editable = editable;
	}

	public function getId():Number {
		return id;
	}

	public function setId(id:Number):Void {
		this.id = id;
	}

	public function getType():Number {
		return type;
	}

	public function setType(type:Number):Void {
		this.type = type;
	}

}