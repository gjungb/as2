class com.adgamewonderland.test.Human extends MovieClip {
	var myName:String;
	var _myName:String;
	var myAge:Number;
	var name_txt:TextField;
	function Human(name:String, age:Number) {
		myName = _myName;
		myAge = age;
	}
	function showName() {
		this.createTextField("name_txt", 2, 0, 0, 200, 30);
		this.name_txt.text = this.myName;
	}
}
