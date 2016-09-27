package mokha.managers.input;

import kha.input.Keyboard;
import kha.Key;

/**
	Manages keyboard input.
**/
class KeyboardInputManager {
	/**
		Reference to existing keyboard input manager instance.
	**/
	static var instance : KeyboardInputManager;

	/**
		A map of keys that were pressed during a frame.
	**/
	public var keysPressed : Map<String, Bool>;
	
	/**
		`true` if any key is pressed this frame.
	**/
	public var isPressed : Bool;

	/**
		`true` if any key was pressed last frame.
	**/
	public var justPressed : Bool;

	/**
		Creates new keyboard input manager.
	**/
	function new() : Void {
		Keyboard.get().notify(onDown, onUp);
		keysPressed = new Map<String, Bool>();
	}

	/**
		Gets or creates keyboard input manager instance.
	**/
	public static function get() : KeyboardInputManager {
		if (instance == null) instance = new KeyboardInputManager(); 
		return instance;
	}

	/**
		Updates keyboard input manager state.
	**/
	public function update() : Void {
		justPressed = false;
	}

	/**
		Performs a check to see if a key is pressed this frame.
		Keys are stored as lowercase strings.
		@param	key	Keyboard key (including characters and special keys)
		@return `true` if key is pressed
	**/
	public function isPressedKey(key : String) : Bool {
		return isPressed && (keysPressed.exists(key));
	}

	/**
		Performs a check to see if a key was pressed in the last
		frame. Keys are stored as lowercase strings.
		@param	key	Keyboard key (including characters and special keys)
		@return	`true` if key was pressed
	**/
	public function justPressedKey(key : String) : Bool {
		return justPressed && (keysPressed.exists(key));
	}

	/**
		Handles the event of a keyboard key being held down.
		@param	key		Keyboard key
		@param	char	Character (if applicable)
	**/
	function onDown(key : Key, char : String) : Void {
		keysPressed.set(key.getName().toLowerCase(), true);
		keysPressed.set(char.toLowerCase(), true);
		isPressed = true;
		justPressed = true;
	}
	/**
		Handles the event of a keyboard key being released.
		@param	key		Keyboard key
		@param	char	Character (if applicable)
	**/
	function onUp(key : Key, char : String) : Void {
		keysPressed.remove(key.getName().toLowerCase());
		keysPressed.remove(char.toLowerCase());
		isPressed = false;
	}
}
