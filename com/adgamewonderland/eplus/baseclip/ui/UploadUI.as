import com.adgamewonderland.eplus.baseclip.ui.InputUI;
import flash.net.FileReference;
import mx.utils.Delegate;
import com.adgamewonderland.eplus.baseclip.connectors.Phase1Connector;
import com.adgamewonderland.eplus.baseclip.controllers.ParticipationController;
import mx.controls.ProgressBar;
import com.adgamewonderland.agw.Formprocessor;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.UploadUI extends InputUI {

	private static var CONTENTTYPES:Array = [{description: "Handy-Video (*.3gp,*.3g2)", extension: "*.3gp;*.3g2"}, {description: "MPEG-Video (*.mpg,*.mpeg,*.mp4)", extension: "*.mpg;*.mpeg;*.mp4"}, {description: "Windows-Video (*.avi)", extension: "*.avi"}]; // , {description: "QuickTime-Film (*.mov)", extension: "*.mov"}, {description: "Windows-Medien (*.asf,*.wmv)", extension: "*.asf;*.wmv"}

	private static var MAXUPLOADSIZE:Number = 5 * 1024 * 1024; // 5 MB

	private var title:String;

	private var fileref:FileReference;

	private var title_txt:TextField;

	private var browse_btn:Button;

	private var progress_mc:MovieClip;

	private var progress_txt:TextField;

	public function UploadUI() {
		// titel des videoclips
		this.title = "";
		// hochzuladende datei
		this.fileref = new FileReference();
		// als listener bei filereference anmelden
		this.fileref.addListener(this);
	}

	public function getFileref():FileReference {
		return this.fileref;
	}

	public function setTitle(title:String):Void
	{
		this.title = title;
	}

	public function getTitle():String
	{
		return this.title;
	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// button datei auswaehlen
		browse_btn.onRelease = Delegate.create(this, doBrowse);
		// fortschrittsbalken ausblenden
		progress_mc._visible = false;
		// fortschrittsanzeige
		progress_txt.autoSize = "left";
		// als ui beim controller registrieren
		ParticipationController.getInstance().addUI(this, ParticipationController.STATUS_UPLOAD);
	}

	private function doBrowse():Void
	{
	    // title
	    setTitle(title_txt.text);
		// validierung
		var errors:Array = this.getErrors();
		// testen, ob ohne fehler
		if (errors.length > 0) {
			// fehler anzeigen
			showErrors(errors);
			// nachricht fehlerhafte angaben
			showMessage("Deine Angaben sind nicht korrekt!");
			// abbrechen
			return;
		}
		// fehlermeldung ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// datei zum upload auswaehlen
		getFileref().browse(CONTENTTYPES);
	}

	private function onSelect(file:FileReference):Void
	{
		// testen, ob maximal akzeptierte dateigroessee der datei nicht ueberschritten
		if (file.size > MAXUPLOADSIZE) {
			// meldung anzeigen
			showMessage("Dein Clip darf höchstens 5 MB groß sein!");
			// abbrechen
			return;
		}
		// fehlermeldung ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// button ausblenden
		browse_btn._visible = false;
		// upload starten
		Phase1Connector.uploadFile(file, getTitle(), this, null);
	}

	private function onCancel(file:FileReference):Void {
	}

	private function onOpen(file:FileReference):Void {
	}

	private function onProgress(file:FileReference, bytesLoaded:Number, bytesTotal:Number):Void
	{
		// prozent fortschritt
		var progress:Number = Math.round(bytesLoaded / bytesTotal * 100);
		// fortschrittsbalken anzeigen
		progress_mc._visible = true;
		// fortschrittsbalken skalieren
		progress_mc._xscale = progress;
		// fortschrittsanzeige
		progress_txt.text = progress + " %";
	}

	private function onComplete(file:FileReference):Void
	{
		// controller informieren
		ParticipationController.getInstance().onFinishStatus(ParticipationController.STATUS_UPLOAD);
	}

	private function onHTTPError(file:FileReference, httperror:Number):Void
	{
		// button einblenden
		browse_btn._visible = true;
		// fehlermeldung anzeigen
		showMessage("Es ist ein Fehler aufgetreten!");
	}

	private function onIOError(file:FileReference):Void {
	}

	private function onSecurityError(file:FileReference, errorString:String):Void {
	}

	public function getErrors():Array
	{
		// sind die attribute alle korrekt befuellt
		var errors:Array = new Array();
		// parameter zur uebergabe an den formprocessor
		var params:Array = new Array();
		params.push(Formprocessor.TYPE_EMPTY, "title", getTitle());
		// validieren
		errors = new Formprocessor().checkForm(params);
		// zurueck geben
		return errors;
	}

	private function onUnload():Void
	{
		// als ui beim controller deregistrieren
		ParticipationController.getInstance().removeUI(this, ParticipationController.STATUS_UPLOAD);
	}

}