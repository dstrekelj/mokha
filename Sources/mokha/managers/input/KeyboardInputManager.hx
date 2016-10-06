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
    public var keysPressed(get, null) : Map<String, Bool>;

    /**
        A map of special keys that were pressed during a frame.
    **/
    public var specialKeysPressed(get, null) : Map<String, Bool>;
    
    /**
        `true` if any key is pressed this frame.
    **/
    public var isPressed(get, null) : Bool;

    /**
        `true` if any key was pressed last frame.
    **/
    public var justPressed(get, null) : Bool;

    /**
        `true` if any key was released last frame.
    **/
    public var justReleased(get, null) : Bool;

    /**
        Number of keys pressed.
    **/
    public var keysPressedCount(get, null) : Int;

    /**
        Number of special keys pressed.
    **/
    public var specialKeysPressedCount(get, null) : Int;

    /**
        Creates new keyboard input manager.
    **/
    function new() : Void {
        Keyboard.get().notify(onDown, onUp);
        keysPressed = new Map<String, Bool>();
        specialKeysPressed = new Map<String, Bool>();
        keysPressedCount = 0;
        specialKeysPressedCount = 0;
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
        justReleased = false;

        for (key in keysPressed.keys())
            if (!keysPressed.get(key))
                keysPressed.remove(key);
        
        for (key in specialKeysPressed.keys())
            if (!specialKeysPressed.get(key))
                specialKeysPressed.remove(key);

        if (keysPressedCount == 0 && specialKeysPressedCount == 0) isPressed = false;
    }

    /**
        Performs a check to see if a key is pressed this frame.
        Keys are stored as lowercase strings.
        @param	key	Keyboard key
        @return `true` if key is pressed
    **/
    public function isPressedKey(key : String) : Bool {
        return isPressed && keysPressed.exists(key) && keysPressed.get(key);
    }

    /**
        Performs a check to see if a special key is pressed this
        frame. Keys are stored as lowercase strings.
        @param	key	Special keyboard key
        @return `true` if key is pressed
    **/
    public function isPressedSpecialKey(key : String) : Bool {
        return isPressed && specialKeysPressed.exists(key) && specialKeysPressed.get(key);
    }

    /**
        Performs a check to see if a key was pressed in the last
        frame. Keys are stored as lowercase strings.
        @param	key	Keyboard key
        @return	`true` if key was pressed
    **/
    public function justPressedKey(key : String) : Bool {
        return justPressed && keysPressed.exists(key) && keysPressed.get(key);
    }

    /**
        Performs a check to see if a special key was pressed in the
        last frame. Keys are stored as lowercase strings.
        @param	key	Keyboard key
        @return	`true` if key was pressed
    **/
    public function justPressedSpecialKey(key : String) : Bool {
        return justPressed && specialKeysPressed.exists(key) && specialKeysPressed.get(key);
    }

    /**
        Performs a check to see if a key was just released in the
        last frame. Keys are stored as lowercase strings.
        @param	key	Keyboard key
        @return	`true` if key was just released
    **/
    public function justReleasedKey(key : String) : Bool {
        return justReleased && keysPressed.exists(key) && !keysPressed.get(key);
    }

    /**
        Performs a check to see if a special key was just released in
        the last frame. Keys are stored as lowercase strings.
        @param	key	Keyboard key
        @return	`true` if key was just released
    **/
    public function justReleasedSpecialKey(key : String) : Bool {
        return justReleased && specialKeysPressed.exists(key) && !specialKeysPressed.get(key);
    }

    /**
        Handles the event of a keyboard key being held down.
        @param	key		Keyboard key
        @param	char	Character (if applicable)
    **/
    function onDown(key : Key, char : String) : Void {
        specialKeysPressed.set(key.getName().toLowerCase(), true);
        specialKeysPressedCount += 1;
        if (key.match(Key.CHAR)) {
            keysPressed.set(char.toLowerCase(), true);
            keysPressedCount += 1;
        }
        isPressed = true;
        justPressed = true;
    }

    /**
        Handles the event of a keyboard key being released.
        @param	key		Keyboard key
        @param	char	Character (if applicable)
    **/
    function onUp(key : Key, char : String) : Void {
        specialKeysPressed.set(key.getName().toLowerCase(), false);
        specialKeysPressedCount -= 1;
        if (key.match(Key.CHAR)) {
            keysPressed.set(char.toLowerCase(), false);
            keysPressedCount -= 1;
        }
        justReleased = true;
    }

    @:noCompletion inline function get_keysPressed() return keysPressed;
    
    @:noCompletion inline function get_specialKeysPressed() return specialKeysPressed;
    
    @:noCompletion inline function get_isPressed() return isPressed;

    @:noCompletion inline function get_justPressed() return justPressed;

    @:noCompletion inline function get_justReleased() return justReleased;

    @:noCompletion inline function get_keysPressedCount() return keysPressedCount;

    @:noCompletion inline function get_specialKeysPressedCount() return specialKeysPressedCount;
}
