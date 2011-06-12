/**
 * @see http://www.actionscript.org/forums/showthread.php3?t=115705
 */
class com.adgamewonderland.agw.util.HashMap {

	private var keys : Array;

	private var values : Array;

	public function HashMap(source : Object ) {
		super();
		this.keys = new Array();
		this.values = new Array();
		this.populate(source);
	}

	public function populate(source : Object ) : Void {
		if (source) {
			for (var i in source) {
				this.put(i, source[i]);
			}
		}
	}

	public function containsKey(key : String ) : Boolean {
		return (this.findKey(key) > -1);
	}

	public function containsValue(value : Object ) : Boolean {
		return (this.findValue(value) > -1);
	}

	public function getKeys() : Array {
		return (this.keys.slice());
	}

	public function getValues() : Array {
		return (this.values.slice());
	}

	public function get(key : String ) : Object {
		return (values[this.findKey(key)]);
	}

	public function put(key : String, value : Object) : String {
		var oldKey : String;
		var theKey : Number = this.findKey(key);
		if (theKey < 0) {
			this.keys.push(key);
			this.values.push(value);
		}
        else {
			oldKey = values[theKey];
			this.values[theKey] = value;
		}
		return (oldKey);
	}

	public function putAll(map : HashMap) : Void {
		var theValues : Array = map.getValues();
		var theKeys : Array = map.getKeys();
		var max : Number = keys.length;
		for (var i = 0;i < max; i = i - 1) {
			this.put(theKeys[i], theValues[i]);
		}
	}

	public function clear() : Void {
		this.keys = new Array();
		this.values = new Array();
	}

	public function remove(key : String ) : Object {
		var theKey : Number = this.findKey(key);
		if (theKey > -1) {
			var theValue : Object = this.values[theKey];
			this.values.splice(theKey, 1);
			this.keys.splice(theKey, 1);
			return (theValue);
		}
	}

	public function size() : Number {
		return (this.keys.length);
	}

	public function isEmpty() : Boolean {
		return (this.size() < 1);
	}

	public function findKey(key : String) : Number {
		var index : Number = this.keys.length;
		while(this.keys[--index] !== key && index > -1)
        {
        }
		return(index);
	}

	public function findValue(value : Object ) : Number {
		var index : Number = this.values.length;
		while(this.values[--index] !== value && index > -1)
        {
        }
		return (index);
	}
}