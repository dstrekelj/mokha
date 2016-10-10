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
        A map of keys that are or were pressed during this frame.
        If value is `true`, key remains pressed.
    **/
    public var keysPressed(get, null) : Map<String, Bool>;

    /**
        A map of special keys that are or were pressed during this
        frame. If value is `true`, key remains pressed.
    **/
    public var specialKeysPressed(get, null) : Map<String, Bool>;
    
    /**
        `true` if any key is pressed or remains pressed this frame.
    **/
    public var isPressed(get, null) : Bool;

    /**
        `true` if any key was pressed for this frame.
    **/
    public var justPressed(get, null) : Bool;

    /**
        Last key pressed in this frame. Equal to empty string
        if no key was pressed.
    **/
    public var justPressedKey(get, null) : String;

    /**
        Last special key pressed in this frame. Equal to empty
        string if no special key was pressed.
    **/
    public var justPressedSpecialKey(get, null) : String;

    /**
        `true` if any key was released this frame.
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
        Last key released in this frame. Equal to empty string if no
        key was released. 
    **/
    public var justReleasedKey(get, null) : String;

    /**
        Last special key released in this frame. Equal to empty
        string if no special key was released.
    **/
    public var justReleasedSpecialKey(get, null) : String;

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
        justPressedKey = "";
        justPressedSpecialKey = "";

        justReleased = false;
        justReleasedKey = "";
        justReleasedSpecialKey = "";

        for (key in keysPressed.keys()) {
            if (!keysPressed.get(key)) {
                keysPressed.remove(key);
            }
        }
        
        for (key in specialKeysPressed.keys()) {
            if (!specialKeysPressed.get(key)) {
                specialKeysPressed.remove(key);
            }
        }

        if (keysPressedCount == 0 && specialKeysPressedCount == 0) {
            isPressed = false;
        }
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
        Handles the event of a keyboard key being held down.
        @param	key		Keyboard key
        @param	char	Character (if applicable)
    **/
    function onDown(key : Key, char : String) : Void {
        justPressedSpecialKey = key.getName().toLowerCase();
        specialKeysPressed.set(justPressedSpecialKey, true);
        specialKeysPressedCount += 1;
        
        if (key.match(Key.CHAR)) {
            justPressedKey = char.toLowerCase();
            keysPressed.set(justPressedKey, true);
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
        justReleasedSpecialKey = key.getName().toLowerCase();
        specialKeysPressed.set(justReleasedSpecialKey, false);
        specialKeysPressedCount -= 1;

        if (key.match(Key.CHAR)) {
            justReleasedKey = char.toLowerCase();
            keysPressed.set(justReleasedKey, false);
            keysPressedCount -= 1;
        }

        justReleased = true;
    }

    @:noCompletion inline function get_keysPressed() return keysPressed;

    @:noCompletion inline function get_specialKeysPressed() return specialKeysPressed;

    @:noCompletion inline function get_isPressed() return isPressed;

    @:noCompletion inline function get_justPressed() return justPressed;

    @:noCompletion inline function get_justPressedKey() return justPressedKey;

    @:noCompletion inline function get_justPressedSpecialKey() return justPressedSpecialKey;

    @:noCompletion inline function get_justReleased() return justReleased;

    @:noCompletion inline function get_justReleasedKey() return justReleasedKey;

    @:noCompletion inline function get_justReleasedSpecialKey() return justReleasedSpecialKey;

    @:noCompletion inline function get_keysPressedCount() return keysPressedCount;

    @:noCompletion inline function get_specialKeysPressedCount() return specialKeysPressedCount;
}
