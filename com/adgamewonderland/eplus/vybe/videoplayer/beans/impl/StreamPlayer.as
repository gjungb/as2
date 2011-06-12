import mx.controls.streamingmedia.RTMPPlayer;
import mx.controls.streamingmedia.PlayerNetStream;
import mx.utils.Delegate;
import mx.controls.streamingmedia.StreamingMediaConstants;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.StreamPlayer extends RTMPPlayer {

	public function StreamPlayer(aMediaUrl : String, aMediaType : String, aVideoHolder : MovieClip, aTotalTime : Number) {
		super(aMediaUrl, aMediaType, aVideoHolder, aTotalTime);
	}

	public function getNs():PlayerNetStream
	{
		// zurueck geben
		return _ns;
	}

	public function onNsStatus(info:Object ):Void
	{
		trace("onNsStatus");
		for (var i in info) trace("NetStream: " + i + ": " + info[i]);
	}

	public function onNsMetaData(metadata:Object ):Void
	{
		trace("onNsMetaData");
		for (var i in metadata) trace("NetStream: " + i + ": " + metadata[i]);
	}

	private function startStream(nc:NetConnection):Void
	{
		clearInterval(_connectTimeOutId);
		_connectTimeOutId = null;

		// Create a new PlayerNetStream and pass it the netConnection object as
		// it's argument.
		_ns = new PlayerNetStream(nc, this);

		_ns.onMetaData = Delegate.create(this, onNsMetaData);

		if (_mediaType == StreamingMediaConstants.FLV_MEDIA_TYPE)
		{
			// Attach the stream to a video object, if you forget this step
			// you'll only hear the audio from the PlayerNetStream.
			_video.attachVideo(_ns);
		}
		_video.attachVideo(_ns);
		_videoHeight = _video.height;
		_videoWidth = _video.width;

		// Increase the buffer time so that playback isn't too choppy over
		// slowish network connections
		_ns.setBufferTime(5);

		// Attach the audio portion of the video to the holder mc
		_videoHolder.attachAudio(_ns);

		// Play the media
		_ns.play(_streamName, 0 , -1);
		_isLoading = false;
		_isLoaded = true;
//		_videoHolder._visible = false;
		setPlaying(false);

		if (_isPlayPending)
		{
			this.play(null);
		}
		else
		{
			// Ok, we just got the connection success so any
			// request to pause earlier could not have succeeded.
			// So clear the flag call pause() again.
			_isPausing = false;
			this.pause();
		}

		trace("startStream: " + _ns);

//		_ns.onStatus = Delegate.create(this, onNsStatus);
//
//		_ns.setBufferTime(0.1);

	}

}