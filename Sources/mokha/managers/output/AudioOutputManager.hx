package mokha.managers.output;

import kha.audio1.AudioChannel;
import kha.audio1.Audio;
import kha.Sound;

/**
	Helper class for managing audio output.
**/
class AudioOutputManager {
	/**
		An instance of the audio output manager.
	**/
	static var instance : AudioOutputManager = null;

	/**
		Total number of sounds managed. Used for sound IDs.
	**/
	static var soundCount : Int = 0;

	/**
		A map of all sounds, or rather their audio channels
		mapped to their sound IDs.
	**/
	public var sounds(get, null) : Map<Int, AudioChannel>;

	/**
		Creates new audio output manager.
	**/
	function new() : Void {
		sounds = new Map<Int, AudioChannel>();
	}

	/**
		Retrieves instance of audio output manager.
		@return	Audio output manager instance
	**/
	public static function get() : AudioOutputManager {
		if (instance == null) instance = new AudioOutputManager();
		return instance;
	}

	/**
		Updates audio output manager state.
	**/
	public function update() : Void {

	}

	/**
		Plays sound.
		@param	sound	Sound asset
		@param	loop	If `true`, sound restarts when playback is over
		@param	stream	If `true`, sound is streamed from memory
		@return	Sound ID as integer
	**/
	public function play(sound : Sound, loop : Bool = false, stream : Bool = false) : Int {
		soundCount += 1;
		sounds.set(soundCount, Audio.play(sound, loop));
		return soundCount;
	}

	@:noCompletion inline function get_sounds() return sounds;
}