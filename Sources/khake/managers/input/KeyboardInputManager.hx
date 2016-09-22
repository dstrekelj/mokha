package khake.managers.input;

import kha.input.Keyboard;
import kha.Key;

class KeyboardInputManager {
	static var instance : KeyboardInputManager;

	public var charsPressed : Map<String, Bool>;
	public var keysPressed : Map<String, Bool>;
	public var isPressed : Bool;

	function new() : Void {
		Keyboard.get().notify(onDown, onUp);
		this.charsPressed = new Map<String, Bool>();
		this.keysPressed = new Map<String, Bool>();
	}

	public static function get() : KeyboardInputManager {
		if (instance == null) instance = new KeyboardInputManager(); 
		return instance;
	}

	public function update() : Void {}

	function onDown(key : Key, char : String) : Void {
		keysPressed.set(key.getName().toLowerCase(), true);
		charsPressed.set(char, true);
		isPressed = true;
	}

	function onUp(key : Key, char : String) : Void {
		keysPressed.remove(key.getName().toLowerCase());
		charsPressed.remove(char);
		isPressed = false;
	}
}
