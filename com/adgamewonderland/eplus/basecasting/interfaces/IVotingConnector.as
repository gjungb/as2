/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.IVotingConnector {

	public function saveVote(aEmail:String, aClipId:Number, aScore:Number ):Void;

}