/**
 * @author gerd
 */

import mx.utils.Delegate;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.SliderUI extends MovieClip {
	
	private static var WIDTH:Number = 320;
	
	private var anfasser_mc:MovieClip;
	
	public function SliderUI() {
	}
	
	public function onLoad():Void
	{
		// registrieren
		VideoPlayer.getInstance().addListener(this);
		// anfasser bewegung start
		anfasser_mc.onPress = Delegate.create(this, onPressAnfasser);
		// anfasser bewegung ende
		anfasser_mc.onRelease = anfasser_mc.onReleaseOutside = Delegate.create(this, onReleaseAnfasser);
	}
	
	public function onVideoPlaying(percent:Number ):Void
	{
		// anfasser positionieren
		anfasser_mc._x = Math.round(WIDTH * percent / 100);
	}
	
	public function onStopVideo():Void
	{
		// anfasser positionieren
		anfasser_mc._x = 0;
	}
	
	public function onPressAnfasser():Void
	{
		// draggen
		anfasser_mc.startDrag(false, 0, anfasser_mc._y, WIDTH, anfasser_mc._y);
		// draggen verfolgen
		onEnterFrame = onEnterFrameDragging;
		// sliden starten
		VideoPlayer.getInstance().slideVideoStart();
	}
	
	public function onReleaseAnfasser():Void
	{
		// draggen beenden
		anfasser_mc.stopDrag();
		// draggen verfolgen beenden
		delete(onEnterFrame);
		// sliden beenden
		VideoPlayer.getInstance().slideVideoStop();
	}
	
	public function onEnterFrameDragging():Void
	{
		// procent
		var percent:Number = anfasser_mc._x / WIDTH * 100;
		// sliden
		VideoPlayer.getInstance().slideVideoSlide(percent);
	}
}