/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.aldi.pipeman.beans.Level {
	
	private var id:Number;
	
	private var rows:Number;
	
	private var columns:Number;
	
	private var time:Number;
	
	private var cellsblocked:Number;
	
	private var pipesmust:Number;
	
	public function Level() {
		this.id = 0;
		this.rows = 0;
		this.columns = 0;
		this.time = 0;
		this.cellsblocked = 0;
		this.pipesmust = 0;
	}
	
	public function getRows():Number {
		return rows;
	}

	public function setRows(rows:Number):Void {
		this.rows = Number(rows);
	}

	public function getPipesmust():Number {
		return pipesmust;
	}

	public function setPipesmust(pipesmust:Number):Void {
		this.pipesmust = Number(pipesmust);
	}

	public function getId():Number {
		return id;
	}

	public function setId(id:Number):Void {
		this.id = Number(id);
	}

	public function getColumns():Number {
		return columns;
	}

	public function setColumns(columns:Number):Void {
		this.columns = Number(columns);
	}

	public function getCellsblocked():Number {
		return cellsblocked;
	}

	public function setCellsblocked(cellsblocked:Number):Void {
		this.cellsblocked = Number(cellsblocked);
	}

	public function getTime():Number {
		return time;
	}

	public function setTime(time:Number):Void {
		this.time = time;
	}
	
	public function toString():String {
		return "Level: id=" + getId() + ", time=" + getTime() + ", cellsblocked=" + getCellsblocked();
	}

}