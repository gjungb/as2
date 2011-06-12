interface com.adgamewonderland.cma.adventskalender2006.util.IConnectorListener 
{

	public function onInitGame(sessionid:String):Void;

	public function onSaveUser(uid:Number):Void;

	public function onGetQuestioncount(fids:String):Void;

	public function onGetQuestion(fid:Number, csv:String):Void;
}